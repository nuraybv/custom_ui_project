import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/expense.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  // Veb üçün müvəqqəti yaddaş siyahısı (Chrome-da çökmməsi üçün)
  final List<Expense> _webMemoryList = [];
  int _webIdCounter = 1;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('expenses.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE expenses (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        amount REAL NOT NULL,
        category TEXT NOT NULL,
        date TEXT NOT NULL
      )
    ''');
  }

  // 1. CREATE - Yeni xərc əlavə etmək
  Future<int> createExpense(Expense expense) async {
    if (kIsWeb) {
      // Veb üçün yerli siyahıya əlavə edirik
      final newExp = Expense(
        id: _webIdCounter++,
        title: expense.title,
        amount: expense.amount,
        date: expense.date,
        category: expense.category,
      );
      _webMemoryList.add(newExp);
      return newExp.id!;
    }

    final db = await instance.database;
    return await db.insert('expenses', expense.toMap());
  }

  // 2. READ - Bütün xərcləri gətirmək
  Future<List<Expense>> getAllExpenses() async {
    if (kIsWeb) {
      return List.from(_webMemoryList);
    }

    final db = await instance.database;
    final result = await db.query('expenses', orderBy: 'date DESC');
    return result.map((map) => Expense.fromMap(map)).toList();
  }

  // 3. UPDATE - Mövcud xərci yeniləmək
  Future<int> updateExpense(Expense expense) async {
    if (kIsWeb) {
      final index = _webMemoryList.indexWhere((e) => e.id == expense.id);
      if (index != -1) {
        _webMemoryList[index] = expense;
      }
      return 1;
    }

    final db = await instance.database;
    return await db.update(
      'expenses',
      expense.toMap(),
      where: 'id = ?',
      whereArgs: [expense.id],
    );
  }

  // 4. DELETE - Xərci silmək
  Future<int> deleteExpense(int id) async {
    if (kIsWeb) {
      _webMemoryList.removeWhere((e) => e.id == id);
      return 1;
    }

    final db = await instance.database;
    return await db.delete(
      'expenses',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<void> close() async {
    if (kIsWeb) return;
    final db = await instance.database;
    await db.close();
  }
}
import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/expense.dart';

enum SortOption { dateDescending, dateAscending, amountDescending, amountAscending }

class ExpenseProvider extends ChangeNotifier {
  List<Expense> _expenses = [];
  bool _isLoading = false;
  
  String _selectedCategory = 'All';
  SortOption _selectedSortOption = SortOption.dateDescending;

  bool get isLoading => _isLoading;
  String get selectedCategory => _selectedCategory;
  SortOption get selectedSortOption => _selectedSortOption;

  // Filtrlənmiş və sıralanmış xərclər siyahısı
  List<Expense> get expenses {
    List<Expense> filteredList = _expenses;

    // 1. Kategoriyaya görə filtrləmə
    if (_selectedCategory != 'All') {
      filteredList = filteredList
          .where((e) => e.category.toLowerCase() == _selectedCategory.toLowerCase())
          .toList();
    }

    // 2. Sıralama (Sorting)
    switch (_selectedSortOption) {
      case SortOption.dateDescending:
        filteredList.sort((a, b) => b.date.compareTo(a.date));
        break;
      case SortOption.dateAscending:
        filteredList.sort((a, b) => a.date.compareTo(b.date));
        break;
      case SortOption.amountDescending:
        filteredList.sort((a, b) => b.amount.compareTo(a.amount));
        break;
      case SortOption.amountAscending:
        filteredList.sort((a, b) => a.amount.compareTo(b.amount));
        break;
    }

    return filteredList;
  }

  // Kategoriyanı dəyişmək üçün metod
  void setCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }

  // Sıralama üsulunu dəyişmək üçün metod
  void setSortOption(SortOption sortOption) {
    _selectedSortOption = sortOption;
    notifyListeners();
  }

  Future<void> fetchExpenses() async {
    _isLoading = true;
    notifyListeners();

    _expenses = await DatabaseHelper.instance.getAllExpenses();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addExpense(Expense expense) async {
    await DatabaseHelper.instance.createExpense(expense);
    await fetchExpenses();
  }

  Future<void> updateExpense(Expense expense) async {
    await DatabaseHelper.instance.updateExpense(expense);
    await fetchExpenses();
  }

  Future<void> deleteExpense(int id) async {
    await DatabaseHelper.instance.deleteExpense(id);
    await fetchExpenses();
  }
}
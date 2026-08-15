import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/expense.dart';
import '../providers/expense_provider.dart';
import '../widgets/expense_item.dart';
import '../widgets/receipt_image_picker.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesScreenState();
}

class _ExpensesScreenState extends State<ExpensesScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
      Provider.of<ExpenseProvider>(context, listen: false).fetchExpenses()
    );
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ExpenseProvider>(context);
    double totalExpense = provider.expenses.fold(0, (sum, item) => sum + item.amount);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Tracker', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // 📊 Toplam Məbləğ Kartı
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Colors.deepPurple, Colors.purpleAccent],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.purple.withValues(alpha: 0.3),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                )
              ],
            ),
            child: Column(
              children: [
                const Text('Total Expenses', style: TextStyle(color: Colors.white70, fontSize: 16)),
                const SizedBox(height: 8),
                Text(
                  '\$${totalExpense.toStringAsFixed(2)}',
                  style: const TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),

          // 🔍 Filtrləmə və Sıralama
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DropdownButton<String>(
                  value: provider.selectedCategory,
                  items: <String>['All', 'Food', 'Transport', 'Bills', 'Entertainment', 'Other']
                      .map((cat) => DropdownMenuItem(value: cat, child: Text(cat)))
                      .toList(),
                  onChanged: (val) {
                    if (val != null) provider.setCategory(val);
                  },
                ),
                DropdownButton<SortOption>(
                  value: provider.selectedSortOption,
                  items: const [
                    DropdownMenuItem(value: SortOption.dateDescending, child: Text('Newest First')),
                    DropdownMenuItem(value: SortOption.dateAscending, child: Text('Oldest First')),
                    DropdownMenuItem(value: SortOption.amountDescending, child: Text('Highest Amount')),
                    DropdownMenuItem(value: SortOption.amountAscending, child: Text('Lowest Amount')),
                  ],
                  onChanged: (val) {
                    if (val != null) provider.setSortOption(val);
                  },
                ),
              ],
            ),
          ),

          const Divider(),

          // 📋 Siyahı / Pull-to-Refresh vəziyyəti
          Expanded(
            child: provider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : provider.expenses.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.receipt_long, size: 80, color: Colors.grey[400]),
                            const SizedBox(height: 12),
                            Text(
                              'No expenses found!',
                              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      )
                    : RefreshIndicator(
                        onRefresh: () async {
                          await provider.fetchExpenses();
                        },
                        child: ListView.builder(
                          itemCount: provider.expenses.length,
                          itemBuilder: (ctx, i) {
                            final expense = provider.expenses[i];
                            return ExpenseItem(
                              expense: expense,
                              onDelete: () {
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: const Text('Delete Expense'),
                                    content: const Text('Are you sure you want to delete this expense?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.of(context).pop(),
                                        child: const Text('Cancel'),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                                        onPressed: () {
                                          provider.deleteExpense(expense.id!);
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Delete', style: TextStyle(color: Colors.white)),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddExpenseModal(context, provider),
        label: const Text('Add Expense'),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
      ),
    );
  }

  void _showAddExpenseModal(BuildContext context, ExpenseProvider provider) {
    final formKey = GlobalKey<FormState>();
    final titleController = TextEditingController();
    final amountController = TextEditingController();
    String selectedCat = 'Food';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          top: 20,
          left: 20,
          right: 20,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Add New Expense', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) return 'Please enter a title';
                    return null;
                  },
                ),
                TextFormField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Amount (\$)'),
                  validator: (val) {
                    if (val == null || val.trim().isEmpty) return 'Please enter an amount';
                    final parsed = double.tryParse(val);
                    if (parsed == null || parsed <= 0) return 'Please enter a valid positive number';
                    return null;
                  },
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  initialValue: selectedCat,
                  items: ['Food', 'Transport', 'Bills', 'Entertainment', 'Other']
                      .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                      .toList(),
                  onChanged: (val) => selectedCat = val!,
                  decoration: const InputDecoration(labelText: 'Category'),
                ),
                const SizedBox(height: 16),
                const ReceiptImagePicker(),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                    minimumSize: const Size(double.infinity, 45),
                  ),
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      final newExpense = Expense(
                        title: titleController.text.trim(),
                        amount: double.parse(amountController.text.trim()),
                        date: DateTime.now(),
                        category: selectedCat,
                      );
                      provider.addExpense(newExpense);
                      Navigator.of(ctx).pop();
                    }
                  },
                  child: const Text('Save Expense', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
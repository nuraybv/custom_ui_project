import 'package:flutter/material.dart';
import '../../models/expense.dart';
import '../screens/detail_screen.dart'; // 1. DetailScreen-i bura əlavə edirik

class ExpenseItem extends StatelessWidget {
  final Expense expense;
  final VoidCallback onDelete;

  const ExpenseItem({
    super.key,
    required this.expense,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Colors.deepPurple,
          child: Icon(Icons.payment, color: Colors.white),
        ),
        title: Text(expense.title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${expense.category} • ${expense.date.toString().split(' ')[0]}'),
        
        // 2. BURANI (onTap) ƏLAVƏ EDİRİK:
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(
                title: expense.title,
                description: 'Category: ${expense.category}\nAmount: \$${expense.amount.toStringAsFixed(2)}\nDate: ${expense.date.toString().split(' ')[0]}',
                imageUrl: null,
              ),
            ),
          );
        },

        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '\$${expense.amount.toStringAsFixed(2)}',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
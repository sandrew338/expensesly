import 'package:expensesly/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  ExpenseItem(this.expenseItem, {super.key});
  Expense expenseItem;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(expenseItem.title),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('\$${expenseItem.amount.toStringAsFixed(2)}'),
              ),
              const Spacer(),
              Icon(categoryIcons[expenseItem.category]),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(expenseItem.formattedDate),
              ),
            ],
          )
        ],
      ),
    );
  }
}

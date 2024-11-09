import 'package:expensesly/custom_widgets.dart/expense_item.dart';
import 'package:expensesly/models/expense.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  const ExpenseList(
      {super.key, required this.expesnses, required this.onRemoveItem});

  final List<Expense> expesnses;
  final void Function(Expense) onRemoveItem;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
          itemCount: expesnses.length,
          itemBuilder: (BuildContext context, int index) {
            return Dismissible(
                key:UniqueKey(),
                onDismissed: (DismissDirection direction) {
                  onRemoveItem(expesnses[index]);
                },
                child: ExpenseItem(expesnses[index]));
          }),
    );
  }
}

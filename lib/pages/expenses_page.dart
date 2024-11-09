import 'package:expensesly/custom_widgets.dart/chart.dart';
import 'package:expensesly/custom_widgets.dart/expense_list.dart';
import 'package:expensesly/models/expense.dart';
import 'package:expensesly/pages/new_expense_page.dart';
import 'package:flutter/material.dart';

class ExpensesPage extends StatefulWidget {
  const ExpensesPage({super.key});

  @override
  State<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends State<ExpensesPage> {
  final List<Expense> _listOfExpenses = [
    Expense(
        title: 'Food for trip',
        amount: 900,
        date: DateTime.now(),
        category: Category.food),
    Expense(
        title: 'YouTube',
        amount: 200,
        date: DateTime.now(),
        category: Category.subs),
    Expense(
        title: 'Trip',
        amount: 200,
        date: DateTime.now(),
        category: Category.travel),
    
  ];

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (ctx) => NewExpensePage(onAddExpense: _addExpense));
  }

  void _addExpense(Expense expense) {
    setState(() {
      _listOfExpenses.add(expense);
      print("\n\nList after adding: $_listOfExpenses\n\n");
    });
  }

  void _removeExpense(Expense expense) {
    final removedExpenseIndex = _listOfExpenses.indexOf(expense);
    setState(() {
      _listOfExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 3),
      content: const Text("Expense deleted."),
      action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _listOfExpenses.insert(removedExpenseIndex, expense);
            });
          }),
    ));
    print("\n\nList after removing: $_listOfExpenses\n\n");
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent = _listOfExpenses.isNotEmpty
        ? ExpenseList(
            expesnses: _listOfExpenses,
            onRemoveItem: _removeExpense,
          )
        : const Center(child: Text("Try add some expenses to see!"));
    return Scaffold(
        appBar: AppBar(
          title: const Text('Expense Tracker'),
          actions: [
            IconButton(
                onPressed: _openAddExpenseOverlay, icon: const Icon(Icons.add))
          ],
        ),
        body: Column(children: [
          Chart(expenses: _listOfExpenses),
          mainContent,
        ]));
  }
}

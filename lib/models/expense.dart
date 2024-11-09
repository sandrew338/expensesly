import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

final formatter = DateFormat.yMd();

enum Category { food, travel, subs, leisure, clothes }

const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.travel_explore,
  Category.subs: Icons.subscriptions,
  Category.leisure: Icons.airline_seat_recline_extra,
  Category.clothes: Icons.boy_rounded,
};

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();
  String get formattedDate {
    return formatter.format(date);
  }

  @override
  String toString() {
    return 'Expense(id: $id, title: $title, amount: $amount, date: $date, category: $category)';
  }
}

class ExpenseBucket {
  final Category category;
  final List<Expense> expenses;

  ExpenseBucket(this.category, this.expenses);
  ExpenseBucket.forCategory( List<Expense> allExpenses, this.category,)
      : expenses = allExpenses
            .where(
              (element) => element.category == category,
            )
            .toList();
  double get totalExpenses {
    double sum = 0.0;
    // for (var i = 0; i < expenses.length; i++) {
    //   Expense currentExpense = expenses[i];
    //   if(currentExpense.category == category)
    //   {
    //     sum += currentExpense.amount;
    //   }
    // }

    // or
    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}

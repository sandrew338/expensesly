import 'package:expensesly/models/expense.dart';
import 'package:flutter/material.dart';

class NewExpensePage extends StatefulWidget {
  const NewExpensePage({super.key, required this.onAddExpense});
  final Function onAddExpense;
  @override
  State<NewExpensePage> createState() => _NewExpensePageState();
}

class _NewExpensePageState extends State<NewExpensePage> {
  final _titleController = TextEditingController();
  final _amountConroller = TextEditingController();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.leisure;

  void _presentDatePicker() async {
    final currentTime = DateTime.now();
    final firstDate = DateTime(currentTime.year - 1);
    final pickedDate = await showDatePicker(
        context: context, firstDate: firstDate, lastDate: currentTime);
    setState(() {
      _selectedDate = pickedDate;
    });
  }

  void _submitExpenseData() {
    final enteredAmount = double.tryParse(_amountConroller.text);
    final isInvalidAmount = enteredAmount == null || enteredAmount < 0;
    if (_titleController.text.trim().isEmpty ||
        isInvalidAmount ||
        _selectedDate == null) {
      //show an error message
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text('Invalid input'),
                content: const Text(
                    'Please, make sure title, amount, date was entered'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Okay'))
                ],
              ));
      return;
    }

    Expense newExpense = Expense(
        amount: enteredAmount,
        category: _selectedCategory,
        title: _titleController.text,
        date: _selectedDate!);
    widget.onAddExpense(newExpense);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32,),
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(
              labelText: 'Title',
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  keyboardType: TextInputType.number,
                  controller: _amountConroller,
                  decoration: const InputDecoration(
                      label: Text('Amount'), prefixText: '\$'),
                ),
              ),
              const SizedBox(width: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(_selectedDate == null
                      ? 'pick a date'
                      : formatter.format(_selectedDate!)),
                  IconButton(
                    onPressed: _presentDatePicker,
                    icon: const Icon(Icons.calendar_month),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              DropdownButton(
                value: _selectedCategory,
                items: Category.values
                    .map((category) => DropdownMenuItem(
                          value: category,
                          child: Text(category.name.toUpperCase()),
                        ))
                    .toList(),
                onChanged: (category) {
                  if (category == null) {
                    return;
                  }
                  setState(() {
                    _selectedCategory = category;
                  });
                },
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Cancel',
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                onPressed: _submitExpenseData,
                child: const Text(
                  'Save Expense',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

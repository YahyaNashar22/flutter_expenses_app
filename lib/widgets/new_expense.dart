import 'dart:developer';
import 'dart:io';

import 'package:expenses_app/models/expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewExpense extends StatefulWidget {
  const NewExpense({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final formatter = DateFormat.yMd();
  DateTime? _selectedDate;
  Category _selectedCategory = Category.food;

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _amountController.dispose();
  }

  void _showDialog() {
    Platform.isIOS
        ? showCupertinoDialog(
            context: context,
            builder: (ctx) => CupertinoAlertDialog(
                    title: const Text("Invalid Input"),
                    content: const Text("Please fill in all fields"),
                    actions: [
                      TextButton(
                        child: const Text("Okay"),
                        onPressed: () => Navigator.pop(ctx),
                      )
                    ]))
        : showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                title: const Text("Invalid Input"),
                content: const Text("Please fill in all fields"),
                actions: [
                  TextButton(
                    child: const Text("Okay"),
                    onPressed: () => Navigator.pop(ctx),
                  )
                ]),
          );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text("Title"),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        label: Text("Amount"),
                        prefixText: "\$",
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          _selectedDate == null
                              ? "No Date Selected"
                              : formatter.format(_selectedDate!),
                        ),
                        IconButton(
                            onPressed: () async {
                              final now = DateTime.now();
                              final firstDate = DateTime(now.year - 1);
                              final DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: now,
                                  firstDate: firstDate,
                                  lastDate: now);
                              setState(() {
                                _selectedDate = pickedDate;
                              });
                            },
                            icon: const Icon(Icons.calendar_month))
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  DropdownButton(
                      value: _selectedCategory,
                      items: Category.values
                          .map((e) => DropdownMenuItem(
                                value: e,
                                child: Text(e.name.toUpperCase()),
                              ))
                          .toList(),
                      onChanged: (newCat) {
                        setState(() {
                          if (newCat == null) return;
                          _selectedCategory = newCat;
                        });
                      }),
                  const Spacer(),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Cancel"),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        final enteredAmount =
                            double.tryParse(_amountController.text);
                        final bool amountIsInvalid =
                            enteredAmount == null || enteredAmount <= 0;

                        if (_titleController.text.trim().isEmpty ||
                            amountIsInvalid ||
                            _selectedDate == null) {
                          log("Error");
                          _showDialog();
                        } else {
                          widget.onAddExpense(
                            Expense(
                                title: _titleController.text,
                                amount: enteredAmount,
                                date: _selectedDate!,
                                category: _selectedCategory),
                          );
                          Navigator.pop(context);
                        }
                      },
                      child: const Text("Save Expense"))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

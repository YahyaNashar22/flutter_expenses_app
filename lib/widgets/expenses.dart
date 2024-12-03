import 'package:expenses_app/models/expense.dart';
import 'package:expenses_app/widgets/chart/chart.dart';
import 'package:expenses_app/widgets/expenses_list/expenses_list.dart';
import 'package:expenses_app/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> expenses = [
    Expense(
      category: Category.work,
      title: "Flutter Course",
      amount: 29.9,
      date: DateTime.now(),
    ),
    Expense(
      category: Category.food,
      title: "H Burger",
      amount: 8.5,
      date: DateTime.now(),
    ),
    Expense(
      category: Category.leisure,
      title: "Movie",
      amount: 12,
      date: DateTime.now(),
    )
  ];

  void _addExpense(Expense expense) {
    setState(() {
      expenses.add(expense);
    });
  }

  void _removeExpense(Expense expense) {
    setState(() {
      expenses.remove(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Expenses App",
            style: TextStyle(
                fontWeight: FontWeight.bold, letterSpacing: 4, wordSpacing: 4),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  useSafeArea: true,
                  isScrollControlled: true,
                  context: context,
                  builder: (ctx) => NewExpense(
                    onAddExpense: _addExpense,
                  ),
                );
              },
              icon: const Icon(Icons.add))
        ],
      ),
      body: expenses.isEmpty
          ? const Center(
              child: Text("No Expenses Found!"),
            )
          : Center(
              child: width < 600
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: Chart(expenses: expenses)),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          "Registered Expenses",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Expanded(
                          child: ExpensesList(
                            expenses: expenses,
                            onRemoveExpense: _removeExpense,
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(child: Chart(expenses: expenses)),
                        const SizedBox(
                          height: 16,
                        ),
                        const Text(
                          "Registered Expenses",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Expanded(
                          child: ExpensesList(
                            expenses: expenses,
                            onRemoveExpense: _removeExpense,
                          ),
                        ),
                      ],
                    ),
            ),
    );
  }
}

import 'package:expenses_app/models/expense.dart';
import 'package:expenses_app/widgets/chart/chart_bar.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.expenses});

  final List<Expense> expenses;

  List<ExpenseBucket> get buckets {
    return [
      ExpenseBucket.forCategory(expenses, Category.food),
      ExpenseBucket.forCategory(expenses, Category.leisure),
      ExpenseBucket.forCategory(expenses, Category.travel),
      ExpenseBucket.forCategory(expenses, Category.work)
    ];
  }

  double get maxTotalExpense {
    double maxTotalExpense = 0;

    for (var element in buckets) {
      if (element.totalExpenses > maxTotalExpense) {
        maxTotalExpense = element.totalExpenses;
      }
    }

    return maxTotalExpense;
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return LayoutBuilder(builder: (ctx, constraint) {
      // ? below are the different constraints for responsive
      // log("minHeight: ${constraint.minHeight.toString()}");
      // log("maxHeight: ${constraint.maxHeight.toString()}");
      // log("minWidth: ${constraint.minWidth.toString()}");
      // log("maxWidth: ${constraint.maxWidth.toString()}");

      return Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        width: double.infinity,
        height: constraint.maxHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary.withOpacity(0.3),
              Theme.of(context).colorScheme.primary.withOpacity(0.0),
            ],
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  for (final e in buckets)
                    ChartBar(
                        fill: e.totalExpenses == 0
                            ? 0
                            : e.totalExpenses / maxTotalExpense),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: buckets
                  .map((e) => Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Icon(
                            categoryIcons[e.category],
                            color: isDarkMode
                                ? Theme.of(context).colorScheme.primary
                                : Theme.of(context)
                                    .colorScheme
                                    .primary
                                    .withOpacity(0.7),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      );
    });
  }
}

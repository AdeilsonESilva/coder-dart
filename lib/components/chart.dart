import 'package:expenses/components/chart_bar.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  const Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactions {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(
          Duration(days: index),
        );

        final totalSum = recentTransactions.fold(
          0.0,
          (prev, element) {
            if (element.date.day == weekDay.day &&
                element.date.month == weekDay.month &&
                element.date.year == weekDay.year) {
              return prev + element.value;
            }
            return prev;
          },
        );

        return {
          'day': DateFormat.E().format(weekDay)[0],
          'value': totalSum,
        };
      },
    );
  }

  double get _weekTotalValue => groupedTransactions.fold(
      0.0, (sum, transaction) => sum + transaction['value']);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: groupedTransactions
              .map((transaction) => Flexible(
                    fit: FlexFit.tight,
                    child: ChartBar(
                      label: transaction['day'],
                      value: transaction['value'],
                      percentage:
                          (transaction['value'] as double) / _weekTotalValue,
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

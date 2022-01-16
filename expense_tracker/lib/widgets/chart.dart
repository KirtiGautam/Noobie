import 'package:expense_tracker/models/transaction.dart';
import 'package:expense_tracker/widgets/bars.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> transactions;

  Chart(this.transactions);

  List<Map<String, Object>> get stats {
    return List.generate(7, (index) {
      final dt = DateTime.now().subtract(
        Duration(days: index),
      );
      var sum = 0.0;
      for (var tx in transactions) {
        if (tx.date.day == dt.day &&
            tx.date.month == dt.month &&
            tx.date.year == dt.year) {
          sum += tx.amount;
        }
      }
      return {'weekDay': DateFormat.E().format(dt), 'amount': sum};
    }).reversed.toList();
  }

  double get weeklySpending =>
      transactions.fold(0.0, (last, next) => last + next.amount);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: stats
              .map(
                (st) => Flexible(
                  fit: FlexFit.tight,
                  child: Bar(st['weekDay'] as String, st['amount'] as double,
                      (st['amount'] as double) / weeklySpending),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

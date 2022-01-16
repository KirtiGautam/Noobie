import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class ListTransactions extends StatelessWidget {
  final List<Transaction> transactions;
  final Function _deleteTx;

  ListTransactions(this.transactions, this._deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: ListView.builder(
          itemCount: transactions.length,
          itemBuilder: (ctx, index) {
            return Card(
              elevation: 5,
              margin: const EdgeInsets.symmetric(
                horizontal: 2,
                vertical: 12,
              ),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 30,
                  child: Padding(
                    padding: const EdgeInsets.all(7),
                    child: FittedBox(
                      child: Text(
                          '₹${transactions[index].amount.toStringAsFixed(2)}'),
                    ),
                  ),
                ),
                title: Text(
                  transactions[index].title,
                ),
                subtitle: Text(
                  DateFormat.yMMMd().format(transactions[index].date),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () => _deleteTx(transactions[index].id),
                ),
              ),
            );
          }),
    );
  }
}

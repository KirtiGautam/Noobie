import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './list_transactions.dart';
import './input_transactions.dart';

class UserTransactions extends StatefulWidget {
  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransactions = [
    Transaction(id: 't1', title: 'iPhone', amount: 21.3, date: DateTime.now()),
    Transaction(id: 't2', title: 'Books', amount: 96.3, date: DateTime.now()),
  ];

  void _addNewTx(String title, double amount) {
    final newTx = Transaction(
        amount: amount,
        title: title,
        date: DateTime.now(),
        id: DateTime.now().toString());

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InputTransaction(_addNewTx),
        ListTransactions(transactions: _userTransactions),
      ],
    );
  }
}

import 'package:expense_tracker/transaction.dart';
import 'package:flutter/material.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(id: 't1', title: 'iPhone', amount: 21.3, date: DateTime.now()),
    Transaction(id: 't2', title: 'Books', amount: 96.3, date: DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense App'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: double.infinity,
            child: const Card(
              color: Colors.blue,
              child: Text(
                'Chart',
              ),
              elevation: 4,
            ),
          ),
          Column(
            children: transactions
                .map((tx) => Card(
                      child: Text(tx.title),
                    ))
                .toList(),
          )
        ],
      ),
    );
  }
}

import 'package:expense_tracker/widgets/chart.dart';
import 'package:flutter/material.dart';

import './widgets/input_transactions.dart';
import './widgets/list_transactions.dart';
import './models/transaction.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App',
      theme: ThemeData(primarySwatch: Colors.purple),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    Transaction(id: 't1', title: 'iPhone', amount: 21.3, date: DateTime.now()),
    Transaction(id: 't2', title: 'Books', amount: 96.3, date: DateTime.now()),
  ];

  List<Transaction> get _recentTx => _userTransactions
      .where(
        (tx) =>
            tx.date.isAfter(DateTime.now().subtract(const Duration(days: 7))),
      )
      .toList();

  void _addNewTx(String title, double amount, DateTime chosenDate) {
    final newTx = Transaction(
      amount: amount,
      title: title,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTx(String id) => setState(
        () => _userTransactions.removeWhere(
          (tx) => id == tx.id,
        ),
      );

  void _showTxModal(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: InputTransaction(_addNewTx),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense App'),
        actions: [
          IconButton(
            onPressed: () => _showTxModal(context),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: double.infinity,
            child: Chart(_recentTx),
          ),
          ListTransactions(
            _userTransactions,
            _deleteTx,
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTxModal(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InputTransaction extends StatefulWidget {
  final Function handleSubmit;

  InputTransaction(this.handleSubmit);

  @override
  State<InputTransaction> createState() => _InputTransactionState();
}

class _InputTransactionState extends State<InputTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  var _selectedDate;

  void _addTx() {
    final String title = _titleController.text;
    final double amount = double.parse(_amountController.text);
    final DateTime txnDt = _selectedDate;

    if (title.isEmpty || amount <= 0 || txnDt == null) {
      return;
    }

    widget.handleSubmit(title, amount, txnDt);
    Navigator.of(context).pop();
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      initialDate: DateTime.now(),
      lastDate: DateTime.now(),
    ).then((dt) {
      if (dt == null) {
        return;
      }
      setState(() {
        _selectedDate = dt;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Title'),
              controller: _titleController,
              onSubmitted: (_) => _addTx(),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              onSubmitted: (_) => _addTx(),
              keyboardType: TextInputType.number,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    (_selectedDate == null)
                        ? 'No date selected'
                        : 'Chosen date: ${DateFormat.yMd().format(_selectedDate)}',
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: _showDatePicker,
                  child: const Text('Choose date'),
                  style: ElevatedButton.styleFrom(
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            ),
            TextButton(
              child: const Text('Add Expense'),
              onPressed: _addTx,
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class InputTransaction extends StatelessWidget {
  final Function handleSubmit;
  final inputController = TextEditingController();
  final amountController = TextEditingController();

  InputTransaction(this.handleSubmit);

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
              decoration: InputDecoration(labelText: 'Title'),
              controller: inputController,
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
            ),
            TextButton(
              style: TextButton.styleFrom(primary: Colors.purple),
              child: const Text('Add Expense'),
              onPressed: () {
                print(inputController.text);
                print(amountController.text);
                handleSubmit(
                    inputController.text, double.parse(amountController.text));
              },
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String qText;

  Question(this.qText);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(12),
      width: double.infinity,
      child: Text(
        qText,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 30),
      ),
    );
  }
}

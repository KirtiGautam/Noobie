import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final VoidCallback onPressHandler;
  final String answerText;

  Answer(this.answerText, this.onPressHandler);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 12, right: 12),
      child: ElevatedButton(
        onPressed: onPressHandler,
        child: Text(answerText),
        style: ButtonStyle(
          alignment: Alignment.center,
        ),
      ),
    );
  }
}

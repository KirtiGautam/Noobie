import 'package:flutter/material.dart';

import 'question.dart';
import 'answer.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int index;
  final Function onPressed;

  Quiz({required this.questions, required this.index, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Question((questions[index]['Q'] as String)),
      ...(questions[index]['ans'] as List<Map<String, Object>>)
          .map((answer) => Answer(answer['text'] as String, () => onPressed(answer['score'])))
          .toList(),
    ]);
  }
}

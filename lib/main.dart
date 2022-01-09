import 'package:flutter/material.dart';

import './quiz.dart';
import './result.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var _index = 0;

  static const _questions = [
    {
      'Q': 'Q1',
      'ans': [
        {"text": 'a1', 'score': 5},
        {'text': 'a2', 'score': 10},
        {'text': 'a3', 'score': 15},
        {'text': 'a4', 'score': 20}
      ]
    },
    {
      'Q': 'Q2',
      'ans': [
        {"text": 'b1', 'score': 5},
        {'text': 'b2', 'score': 10},
        {'text': 'b3', 'score': 15},
        {'text': 'b4', 'score': 20}
      ]
    },
    {
      'Q': 'Q3',
      'ans': [
        {"text": 'c1', 'score': 5},
        {'text': 'c2', 'score': 10},
        {'text': 'c3', 'score': 15},
        {'text': 'c4', 'score': 20}
      ]
    },
    {
      'Q': 'Q4',
      'ans': [
        {"text": 'd1', 'score': 5},
        {'text': 'd2', 'score': 10},
        {'text': 'd3', 'score': 15},
        {'text': 'd4', 'score': 20}
      ]
    },
  ];

  int _totalScore = 0;

  void _onPressed(int score) {
    _totalScore += score;
    setState(() {
      _index += (_index < _questions.length) ? 1 : 0;
    });
  }

  void _resetQuiz() {
    setState(() {
      _totalScore = 0;
      _index = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('YoYO'),
        ),
        body: _index < _questions.length
            ? Quiz(
                index: _index,
                questions: _questions,
                onPressed: _onPressed,
              )
            : Result(_totalScore, _resetQuiz),
      ),
    );
  }
}

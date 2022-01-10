import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  int score;
  final VoidCallback resetQuiz;

  Result(this.score, this.resetQuiz);

  String get getScore {
    String str;
    if (score > 79) {
      str = 'You are the best';
    } else if (score > 59) {
      str = 'You are awesome';
    } else if (score > 39) {
      str = 'You are okay';
    } else {
      str = 'Something wrong with you bro?!';
    }
    return str;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            getScore,
            style: const TextStyle(
                fontSize: 35, fontWeight: FontWeight.bold, color: Colors.green),
          ),
          TextButton(onPressed: resetQuiz, child: const Text('Reset Quiz'))
        ],
      ),
    );
  }
}

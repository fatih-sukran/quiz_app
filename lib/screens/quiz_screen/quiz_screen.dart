import 'package:flutter/material.dart';
import 'package:quiz_app/modal/question_modal.dart';
import 'package:quiz_app/screens/quiz_screen/home.dart';


class QuizScreen0 extends StatefulWidget {
  static const route = '/quizScreen0';
  QuizScreen0(this.context, this._index, this._score);

  final BuildContext context;
  final int _index;
  final double _score;

  @override
  State<QuizScreen0> createState() => QuizScreenState(_index, _score);
}

class QuizScreenState extends State<QuizScreen0> {
  int _index;
  double _score;
  Question _question;

  QuizScreenState(this._index, this._score) {
    _question = Question.questions[_index];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Quiz App")),
      body: Home(context: context, question: _question, score: _score),
    );
  }
}

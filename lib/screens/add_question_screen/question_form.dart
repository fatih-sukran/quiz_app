import 'package:flutter/material.dart';
import 'package:quiz_app/components/myTextField.dart';

class QuestionForm extends StatefulWidget {
  @override
  _QuestionFormState createState() => _QuestionFormState();
}

class _QuestionFormState extends State<QuestionForm> {
  int value = 0;

  @override
  Widget build(BuildContext context) {
    return Form(
      onWillPop: () => Future.delayed(Duration(microseconds: 0), () => true),
      child: Column(
        children: [
          MyTextField(
            labelText: "Soru",
          )
        ],
      ),
    );
  }
}

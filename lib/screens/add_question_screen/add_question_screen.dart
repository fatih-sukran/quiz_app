import 'package:flutter/material.dart';
import 'package:quiz_app/screens/add_question_screen/question_form.dart';

class AddQuestionScreen extends StatefulWidget {
  static const route = '/addQuestionScreen';
  @override
  _AddQuestionScreenState createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends State<AddQuestionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Soru Ekle"),
      ),
      body: home(),
    );
  }

  Widget home() {
    return Container(
      color: Colors.amber,
      child: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.5,
          child: Card(
            color: Colors.red,
            child: Column(
              children: [
                QuestionForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

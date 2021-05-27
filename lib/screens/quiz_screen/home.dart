import 'package:flutter/material.dart';
import 'package:quiz_app/components/button.dart';
import 'package:quiz_app/components/slimy_card.dart';
import 'package:quiz_app/modal/question_modal.dart';

class Home extends StatelessWidget {
  final Question question;
  final double score;
  final BuildContext context;

  const Home({Key key, this.question, this.score, this.context})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: Colors.red,
      //padding: EdgeInsets.all(30),
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: SlimyCard(
              width: size.width,
              topCardHeight: (size.height/10) * 6,
              bottomCardHeight: (size.height/10) * 4,
              topCardWidget: Container(
                padding: EdgeInsets.all(21),
                alignment: Alignment.center,
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Text(
                          "Puan : $score",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "Süre : ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Container(
                      alignment: Alignment.center,
                      color: Colors.red,
                      child: Text(
                        question.soru,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              bottomCardWidget: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    button(question.a, 0),
                    button(question.b, 1),
                    button(question.c, 2),
                    button(question.d, 3),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget button(String text, int id) {
    return Button(
      text: Text(
        text,
        style: Theme.of(context).primaryTextTheme.button,
      ),
      color: Colors.blue,
      onTap: () {
        question.secilen = text;
      },
    );
  }
}

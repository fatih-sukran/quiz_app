import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_app/modal/question_modal.dart';
import 'package:quiz_app/modal/quiz_modal.dart';
import 'package:quiz_app/modal/status.dart';
import 'package:quiz_app/components/button.dart';

class QuizScreen extends StatefulWidget {
  static const route = 'quizScreen';
  
  final BuildContext context;
  QuizScreen(this.context);

  @override
  State<QuizScreen> createState() => QuizScreenState();
}

class QuizScreenState extends State<QuizScreen> with TickerProviderStateMixin {
  Timer timer;
  AnimationController _controllerTimer;
  List<AnimationController> _controllerHeart;
  Quiz _quiz;
  bool isClicked = false;

  QuizScreenState() {
    _quiz = Quiz();
  }

  @override
  void initState() {
    //print("Quiz Screen ::: initState called");

    _controllerTimer = AnimationController(vsync: this)
      ..value = 0.0
      ..addListener(
        () {
          setState(() {});
        },
      )
      ..duration = Duration(seconds: 12);

    _controllerHeart = [
      AnimationController(vsync: this, value: 0.5),
      AnimationController(vsync: this, value: 0.5),
      AnimationController(vsync: this, value: 0.5),
    ];

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      startTimer();
      startTimerAnimation();
    });
    super.initState();
  }

  void startTimerAnimation() {
    //print("startTimerAnimation ::: timer value was 0 and forwarded");
    _controllerTimer.value = 0.0;
    _controllerTimer.forward();
  }

  @override
  void dispose() {
    //print("dispose ::: timer disposed");
    _controllerTimer.dispose();
    super.dispose();
  }

  void startTimer() {
    //print("startTimer ::: Timer was started");
    int sure = 10;
    timer = Timer.periodic(Duration(seconds: 1), (t) {
      //print("remaining time : $sure");
      if (sure == 0) {
        t.cancel();
        //print("startTimer ::: timer cancelled");
        _controllerTimer.stop();
        //print("startTimer ::: controller stopped");
        _quiz.status = Status.timesUp;
        //print("startTimer ::: showDialogWidget called");
        _quiz.control(Question.questions[_quiz.index]);
        _animateCanLottie();
        Future.delayed(Duration(seconds: 1), () => showDialogWidget());
      }
      sure--;
    });
  }

  @override
  Widget build(BuildContext context) {
    ////print("Quiz Screen ::: build was called");

    return Scaffold(
      appBar: AppBar(title: Text("Quiz App")),
      body: _home(),
    );
  }

  Widget _home() {
    return Container(
      color: Colors.redAccent,
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Container(
              padding: EdgeInsets.all(21),
              alignment: Alignment.center,
              width: double.infinity,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 50.0, // soften the shadow
                    spreadRadius: 20.0, //extend the shadow
                    offset: Offset(
                      0.0, // Move to right 10  horizontally
                      10.0, // Move to bottom 10 Vertically
                    ),
                  ),
                ],
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(41),
                  bottomRight: Radius.circular(41),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomCenter,
                  colors: <Color>[
                    Colors.blueAccent,
                    Colors.greenAccent,
                  ],
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Text(
                        "Puan : ${_quiz.score}",
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
                          lottieTimeWidget(),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      lottieCanWidget(id: 0),
                      lottieCanWidget(id: 1),
                      lottieCanWidget(id: 2),
                    ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    color: Colors.red,
                    child: Text(
                      Question.questions[_quiz.index].soru,
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
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  button(Question.questions[_quiz.index].a, 0),
                  button(Question.questions[_quiz.index].b, 1),
                  button(Question.questions[_quiz.index].c, 2),
                  button(Question.questions[_quiz.index].d, 3),
                ],
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
        Question.questions[_quiz.index].secilen = text;
        setState(() {
          _quiz.control(Question.questions[_quiz.index]);
        });
        timer.cancel();
        _controllerTimer.stop();
        print(_quiz.status);
        if (_quiz.status != Status.win) {
          Future.delayed(
            Duration(seconds: 1),
            () => showDialogWidget(),
          );
          _animateCanLottie();
        } else {
          showDialogWidget();
        }
      },
    );
  }

  Future showDialogWidget() {
    //print("showDialogWidget was called");
    return showDialog(
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        title: getDialogText(),
        content: lottieDialogWidget(_quiz.status),
        actionsPadding: EdgeInsets.all(16.0),
        actions: [
          FlatButton(
            padding: EdgeInsets.all(16.0),
            textColor: Colors.white,
            child: Text("Sıradakı Soru"),
            color: Colors.greenAccent,
            onPressed: () {
              setState(() {
                Navigator.of(context).pop();
                //print("Navigator pop ::: Sıradaki Soru Flat Button");
                if (_quiz.passNextQuestion()) {
                  //print("passNextQuestin return true");
                  startTimer();
                  startTimerAnimation();
                } else {
                  //print("passNextQuestin return false");
                  routeResultScreen();
                }
              });
            },
          ),
          SizedBox(width: 8.0),
          FlatButton(
            padding: EdgeInsets.all(16.0),
            textColor: Colors.white,
            child: Text("Quiz'i Bitir"),
            color: Colors.redAccent,
            onPressed: () {
              //print("onPressed ::: Quiz'i Bitir Flat Button");
              Navigator.pop(context);
              //print("Navigator pop ::: Quiz'i Bitir Flat Button");
              routeResultScreen();
            },
          ),
        ],
      ),
      barrierDismissible: false,
      context: context,
    );
  }

  void routeResultScreen() {
    //print("routeResultScreen ::: Navigator replace result screen");
    Navigator.pushReplacementNamed(
      context,
      '/resultScreen/${_quiz.trues}/${_quiz.falses}',
    );
  }

  Widget lottieDialogWidget(Status status) {
    String name;
    if (status == Status.win) {
      name = "assets/lotties/win.json";
    } else if (status == Status.loss) {
      name = "assets/lotties/loss.json";
    } else if (status == Status.timesUp) {
      name = "assets/lotties/time_is_up.json";
    } else {
      throw Exception();
    }
    return Lottie.asset(
      name,
      frameRate: FrameRate(60),
      width: 200,
      height: 200,
      repeat: status == Status.timesUp ? true : false,
    );
  }

  Widget lottieTimeWidget() {
    return Lottie.asset(
      "assets/lotties/timer.json",
      width: 50.0,
      height: 50.0,
      repeat: false,
      reverse: true,
      controller: _controllerTimer,
      onLoaded: (composition) {
        setState(() {
          // print(
          //    "lottieTimeWidget ::: duratition setted : ${composition.duration}");
          _controllerTimer.duration = composition.duration;
        });
      },
    );
  }

  Text getDialogText() {
    String text;
    Color color;
    if (_quiz.status == Status.win) {
      text = "TEBRİKLER!\nDoğru bildiniz!";
      color = Colors.green;
    } else if (_quiz.status == Status.loss) {
      text = "MALESEF!\nYanlış bildiniz!";
      color = Colors.red;
    } else if (_quiz.status == Status.timesUp) {
      text = "SÜRE BİTTİ!";
      color = Colors.red;
    } else {
      throw Exception();
    }

    return Text(
      text,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: color,
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget lottieCanWidget({int id}) {
    return Expanded(
      child: Container(
        width: 100,
        height: 100,
        child: Lottie.asset(
          "assets/lotties/heart.json",
          fit: BoxFit.cover,
          controller: _controllerHeart[id],
        ),
      ),
    );
  }

  void _animateCanLottie() {
    _controllerHeart[_quiz.can]
      ..value = 0.5
      ..addListener(() {
        if (_controllerHeart[_quiz.can].value > 0.9)
          _controllerHeart[_quiz.can].stop();
      })
      ..duration = Duration(seconds: 3)
      ..forward();
  }
}

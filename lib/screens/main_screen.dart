import 'package:flutter/material.dart';
import 'package:quiz_app/auth/firabase_login.dart';
import 'package:quiz_app/components/button.dart';
import 'package:quiz_app/screens/quiz_screen.dart';
import 'package:quiz_app/screens/welcome_screen/welcome_screen.dart';

import '../constansts.dart';

class MainScreen extends StatefulWidget {
  static const route = '/mainScreen';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {

    FirebaseHandler.auth.userChanges().listen((event) {
      if (event == null) {
        Navigator.pushReplacementNamed(context, WelcomeScreen.route);
      }
    });
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          title: Text(Constants.appName),
          subtitle: Text(
            FirebaseHandler.auth.currentUser.displayName ?? 'Null',
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              FirebaseHandler.auth.signOut();
            },
            child: Text(
              "Çıkış Yap",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: Container(
        color: Colors.purple,
        child: Center(
          child: Container(
            color: Colors.transparent,
            height: 200.0,
            width: double.infinity,
            child: Card(
              margin: EdgeInsets.fromLTRB(16.0, 0, 16.0, 32),
              color: Colors.amber,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Button(
                    text: Text(
                      "BAŞLA",
                      style: Theme.of(context).primaryTextTheme.button,
                    ),
                    color: Colors.green,
                    onTap: () =>
                        Navigator.pushNamed(context, QuizScreen.route),
                  ),
                  Button(
                    text: Text(
                      "SORU EKLE",
                      style: Theme.of(context).primaryTextTheme.button,
                    ),
                    color: Colors.green,
                    onTap: () =>
                        Navigator.pushNamed(context, "/addQuestionScreen"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

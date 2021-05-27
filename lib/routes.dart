import 'package:flutter/material.dart';
import 'package:quiz_app/components/example.dart';
import 'package:quiz_app/screens/add_question_screen/add_question_screen.dart';
import 'package:quiz_app/screens/login_screen/login_screen.dart';
import 'package:quiz_app/screens/main_screen.dart';
import 'package:quiz_app/screens/quiz_screen/quiz_screen.dart';
import 'package:quiz_app/screens/welcome_screen/welcome_screen.dart';

import 'screens/sign_up_screen/sign_up_screen.dart';

final Map<String, WidgetBuilder> routes = {
  MainScreen.route: (context) => MainScreen(),
  WelcomeScreen.route: (context) => WelcomeScreen(),
  LoginScreen.route: (context) => LoginScreen(),
  SignUpScreen.route: (context) => SignUpScreen(),
  QuizScreen0.route: (context) => QuizScreen0(context, 0, 0),
  AddQuestionScreen.route: (context) => AddQuestionScreen(),
  Example.route: (context) => Example(),

};

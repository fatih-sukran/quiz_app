import 'package:flutter/material.dart';
import 'package:quiz_app/auth/firabase_login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quiz_app/modal/question_modal.dart';
import 'package:quiz_app/routes.dart';
import 'package:quiz_app/screens/add_question_screen/add_question_screen.dart';
import 'package:quiz_app/screens/main_screen.dart';
import 'package:quiz_app/screens/result_screen.dart';
import 'package:quiz_app/screens/welcome_screen/welcome_screen.dart';
import 'package:quiz_app/services/question_service.dart';

String route;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseHandler.auth.authStateChanges().listen((user) {
    if (user == null) {
      print('main() :: Oturum Kapalı');
      route = WelcomeScreen.route;
      //route = Example.route;
    } else {
      route = MainScreen.route;
      if (user.emailVerified) {
        print('Kullanıcı oturum açtı ve emaili onaylı');
      } else {
        print('Kullanıcı oturum açtı ve emaili onaylı değil');
      }
    }
  });
  Question.questions = await loadQuestions(1);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: route,
      routes: routes,
      onUnknownRoute: (settings) =>
          MaterialPageRoute(builder: (context) => AddQuestionScreen()),
      onGenerateRoute: (settings) {
        var keyList = settings.name.split('/');

        if (keyList[1] == "resultScreen") {
          return MaterialPageRoute(
            builder: (context) =>
                ResultScreen(int.parse(keyList[2]), int.parse(keyList[3])),
          );
        }
        return null;
      },
    );
  }
}

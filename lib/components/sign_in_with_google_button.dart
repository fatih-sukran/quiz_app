import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/auth/firabase_login.dart';
import 'package:quiz_app/screens/main_screen.dart';

class SignInWithGoogleButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("SignInWithGoogleButton ::: build()");
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        margin: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: Colors.black,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              height: 30.0,
              width: 30.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/google.jpg'), fit: BoxFit.cover),
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 10),
            Text(
              'Sign in with Google',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      onTap: () async {
        try {
          print("SignInWithGoogleButton :::: build() ::: onTap :: try");
          UserCredential userCredential =
              await FirebaseHandler.loginWithGoogle();
          if (userCredential.user != null) {
            print(userCredential.user.displayName);
            print(userCredential.user.email);
            print("is e mail verified: ${userCredential.user.emailVerified}");
            Navigator.pushReplacementNamed(context, MainScreen.route);
          }
        } catch (e) {
          print("SignInWithGoogleButton :::: build() ::: onTap :: catch");
        }
      },
    );
  }
}

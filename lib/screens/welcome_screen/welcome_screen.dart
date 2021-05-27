import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/auth/firabase_login.dart';
import 'package:quiz_app/constansts.dart';
import 'package:quiz_app/screens/login_screen/login_screen.dart';
import 'package:quiz_app/theme.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../main_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const route = 'welcomeScreen';
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            SafeArea(
              child: Container(
                width: double.infinity,
                child: SvgPicture.asset(
                  Constants.logo_path,
                  width: 200,
                  height: 200,
                ),
              ),
            ),
            Text(
              "QUIZ APP",
              style: GoogleFonts.rubik(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: MyTheme.accentColor,
              ),
            ),
            Container(
              margin: EdgeInsets.all(16.0),
              padding: EdgeInsets.all(32.0),
              decoration: BoxDecoration(
                color: MyTheme.accentColor,
                borderRadius: BorderRadius.all(Radius.circular(28)),
              ),
              child: Column(
                children: [
                  RoundedLoadingButton(
                    animateOnTap: false,
                    color: MyTheme.secondaryColor,
                    child: Text(
                      'E-Posta ile giriş',
                      style: GoogleFonts.rubik(
                        color: Colors.white,
                        fontSize: 21,
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, LoginScreen.route);
                    },
                  ),
                  SizedBox(height: 16.0),
                  RoundedLoadingButton(
                    color: Colors.black,
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, right: 8.0),
                            child: SvgPicture.asset(
                              "assets/icons/google_icon.svg",
                              width: 36,
                              height: 36,
                            ),
                          ),
                          Text(
                            'Google ile giriş',
                            style: GoogleFonts.rubik(
                              color: Colors.white,
                              fontSize: 21,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () async {
                      try {
                        print(
                            "SignInWithGoogleButton :::: build() ::: onTap :: try");
                        UserCredential userCredential =
                            await FirebaseHandler.loginWithGoogle();
                        if (userCredential.user != null) {
                          print(userCredential.user.displayName);
                          print(userCredential.user.email);
                          print(
                              "is e mail verified: ${userCredential.user.emailVerified}");
                          Navigator.pushReplacementNamed(
                              context, MainScreen.route);
                        }
                      } catch (e) {
                        print(
                            "SignInWithGoogleButton :::: build() ::: onTap :: catch");
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/auth/firabase_login.dart';
import 'package:quiz_app/components/my_snacbar.dart';
import 'package:quiz_app/components/my_text_field.dart';
import 'package:quiz_app/constansts.dart';
import 'package:quiz_app/screens/sign_up_screen/sign_up_screen.dart';
import 'package:quiz_app/theme.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../main_screen.dart';

class LoginScreen extends StatefulWidget {
  static final route = '/loginScreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FocusNode _emailFocus;
  FocusNode _passwordFocus;
  FocusNode _loginFocus;

  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _buttonController = RoundedLoadingButtonController();

  @override
  void initState() {
    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
    _loginFocus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _loginFocus.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _home(
        context: context,
        emailFocus: _emailFocus,
        passwordFocus: _passwordFocus,
        loginFocus: _loginFocus,
        emailController: _emailController,
        passwordController: _passwordController,
        buttonController: _buttonController,
        formKey: _formKey,
      ),
    );
  }
}

Widget _home({
  BuildContext context,
  FocusNode emailFocus,
  FocusNode passwordFocus,
  FocusNode loginFocus,
  TextEditingController emailController,
  TextEditingController passwordController,
  RoundedLoadingButtonController buttonController,
  GlobalKey<FormState> formKey,
}) {
  double width = MediaQuery.of(context).size.width;
  double height = MediaQuery.of(context).size.height;

  return Container(
    color: Colors.white,
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SafeArea(
            child: SvgPicture.asset(
              Constants.log_in_path,
              width: MediaQuery.of(context).size.width,
              //todo: placeholder ekle
              placeholderBuilder: (context) => Placeholder(
                color: Colors.amber,
                fallbackWidth: 200,
                fallbackHeight: 200,
              ),
            ),
          ),
          Form(
            key: formKey,
            child: Container(
              height: (height - (width / 4) * 3) - 20,
              margin: EdgeInsets.all(8.0),
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: MyTheme.accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Giriş",
                    style: GoogleFonts.rubik(
                      fontSize: Theme.of(context).textTheme.headline2.fontSize,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MyTextField(
                      label: "E-Posta adresi",
                      controller: emailController,
                      focusNode: emailFocus,
                      textInputAction: TextInputAction.next,
                      prefixIconData: Icons.mail,
                      onFieldSubmitted: (a) {
                        emailFocus.unfocus();
                        FocusScope.of(context).requestFocus(passwordFocus);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return '';
                        }
                        if (!RegExp(Constants.emailRegex).hasMatch(value)) {
                          return 'Geçerli bir e-posta adresi girin!';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MyTextField(
                      label: "Şifre",
                      controller: passwordController,
                      focusNode: passwordFocus,
                      prefixIconData: Icons.lock,
                      suffixIconData: Icons.visibility_off,
                      onFieldSubmitted: (a) {
                        emailFocus.unfocus();
                        FocusScope.of(context).requestFocus(loginFocus);
                      },
                      validator: (value) => value.length < 8 ? '' : null,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 30, bottom: 8.0),
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          "Şifremi unuttum",
                          textAlign: TextAlign.right,
                          style: GoogleFonts.rubik(
                            color: Colors.white,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                  RoundedLoadingButton(
                    color: MyTheme.secondaryColor,
                    controller: buttonController,
                    child: Text(
                      'Giriş Yap',
                      style: GoogleFonts.rubik(
                        color: Colors.white,
                        fontSize: 21,
                      ),
                    ),
                    onPressed: () async {
                      if (formKey.currentState.validate()) {
                        try {
                          print("email: ${emailController.text}");
                          print("password: ${passwordController.text}");
                          var login = await FirebaseHandler.auth
                              .signInWithEmailAndPassword(
                            email: emailController.value.text,
                            password: passwordController.text,
                          );
                          if (login.user != null) {
                            buttonController.success();
                            Navigator.pushReplacementNamed(
                                context, MainScreen.route);
                          } else {
                            print("not validate");
                          }
                        } catch (e) {
                          print("loginButton ::: press :: catch :");

                          ScaffoldMessenger.of(context)
                              .showSnackBar(getSnackBar(
                            context: context,
                            mySnackBar: MySnackBar.error,
                            title: 'HATA',
                            message: FirebaseHandler.translateExceptionMessage(
                                e.code),
                          ));

                          buttonController.error();
                          Future.delayed(Duration(seconds: 2),
                              () => buttonController.reset());
                        }
                      } else {
                        buttonController.error();
                        Future.delayed(Duration(seconds: 2),
                            () => buttonController.reset());
                        ScaffoldMessenger.of(context).showSnackBar(getSnackBar(
                          context: context,
                          mySnackBar: MySnackBar.error,
                          title: 'Boş Alanları Doldurun',
                          message: null,
                        ));
                      }
                    },
                  ),
                  Spacer(),
                  FlatButton(
                    onPressed: () {
                      Navigator.pushNamed(context, SignUpScreen.route);
                    },
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "Hesabın yokmu? Hesap Oluştur",
                        style: GoogleFonts.rubik(
                            fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

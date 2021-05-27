import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quiz_app/auth/firabase_login.dart';
import 'package:quiz_app/components/my_snacbar.dart';
import 'package:quiz_app/components/my_text_field.dart';
import 'package:quiz_app/constansts.dart';
import 'package:quiz_app/screens/login_screen/login_screen.dart';
import 'package:quiz_app/theme.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../main_screen.dart';

class SignUpScreen extends StatefulWidget {
  static final route = '/signUpScreen';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  FocusNode _nameFocus;
  FocusNode _surnameFocus;
  FocusNode _emailFocus;
  FocusNode _passwordFocus;
  FocusNode _againPasswordFocus;
  FocusNode _submitFocus;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _againPasswordController = TextEditingController();
  final _buttonController = RoundedLoadingButtonController();

  @override
  void initState() {
    _nameFocus = FocusNode();
    _surnameFocus = FocusNode();
    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
    _againPasswordFocus = FocusNode();
    _submitFocus = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _nameFocus.dispose();
    _surnameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _againPasswordFocus.dispose();
    _submitFocus.dispose();

    _nameController.dispose();
    _surnameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _againPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _home(
        context: context,
        nameFocus: _nameFocus,
        surnameFocus: _surnameFocus,
        emailFocus: _emailFocus,
        passwordFocus: _passwordFocus,
        againPasswordFocus: _againPasswordFocus,
        loginFocus: _submitFocus,
        nameController: _nameController,
        surnameController: _surnameController,
        emailController: _emailController,
        passwordController: _passwordController,
        againPasswordController: _againPasswordController,
        buttonController: _buttonController,
        formKey: _formKey,
      ),
    );
  }
}

Widget _home({
  BuildContext context,
  FocusNode nameFocus,
  FocusNode surnameFocus,
  FocusNode emailFocus,
  FocusNode passwordFocus,
  FocusNode againPasswordFocus,
  FocusNode loginFocus,
  TextEditingController nameController,
  TextEditingController surnameController,
  TextEditingController emailController,
  TextEditingController passwordController,
  TextEditingController againPasswordController,
  RoundedLoadingButtonController buttonController,
  GlobalKey<FormState> formKey,
}) {
  return Container(
    color: Colors.white,
    child: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
              bottom: 8,
            ),
            child: SafeArea(
              child: SvgPicture.asset(
                Constants.sign_up_path,
                width: MediaQuery.of(context).size.width - 32,
              ),
            ),
          ),
          Container(
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
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Text(
                    "Kayıt Ol",
                    style: GoogleFonts.rubik(
                      fontSize: Theme.of(context).textTheme.headline2.fontSize,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MyTextField(
                      label: "Ad",
                      controller: nameController,
                      focusNode: nameFocus,
                      textInputAction: TextInputAction.next,
                      prefixIconData: Icons.person,
                      onFieldSubmitted: (a) {
                        nameFocus.unfocus();
                        FocusScope.of(context).requestFocus(surnameFocus);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Bu alanı doldurun!';
                        }
                        if (value.length < 3)
                          return 'Geçerli bir isim giriniz!';
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MyTextField(
                      label: "Soyad",
                      controller: surnameController,
                      focusNode: surnameFocus,
                      textInputAction: TextInputAction.next,
                      prefixIconData: Icons.person,
                      onFieldSubmitted: (a) {
                        surnameFocus.unfocus();
                        FocusScope.of(context).requestFocus(emailFocus);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Bu alanı doldurun';
                        }
                        if (value.length < 3)
                          return 'Geçerli bir isim giriniz!';
                        return null;
                      },
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
                          return 'Bu alanı doldurun';
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
                      onFieldSubmitted: (a) {
                        passwordFocus.unfocus();
                        FocusScope.of(context).requestFocus(againPasswordFocus);
                      },
                      validator: (value) => value.length < 8
                          ? 'En az 8 haneli bir şifre giriniz'
                          : null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MyTextField(
                      label: "Tekrar Şifre",
                      controller: againPasswordController,
                      focusNode: againPasswordFocus,
                      textInputAction: TextInputAction.done,
                      prefixIconData: Icons.lock,
                      onFieldSubmitted: (a) {
                        againPasswordFocus.unfocus();
                      },
                      validator: (value) {
                        if (passwordController.text != value)
                          return "Şifreler eşleşmiyor!";
                        return null;
                      },
                    ),
                  ),
                  RoundedLoadingButton(
                    color: MyTheme.secondaryColor,
                    controller: buttonController,
                    child: Text(
                      'Kayıt Ol',
                      style: GoogleFonts.rubik(
                        color: Colors.white,
                        fontSize: 21,
                      ),
                    ),
                    onPressed: () async {
                      if (formKey.currentState.validate()) {
                        try {
                          var signup = await FirebaseHandler.auth
                              .createUserWithEmailAndPassword(
                            email: emailController.value.text,
                            password: passwordController.text,
                          );
                          if (signup.user != null) {
                            String name = nameController.text;
                            String surname = surnameController.text;
                            await signup.user
                                .updateProfile(displayName: "$name $surname");
                            buttonController.success();
                            Navigator.pushReplacementNamed(
                                context, MainScreen.route);
                          } else {
                            buttonController.error();
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
                      }
                    },
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.pushNamed(context, LoginScreen.route);
                    },
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "Hesabın var mı? Giriş Yap",
                        style: GoogleFonts.rubik(
                          fontSize: 18,
                          color: Colors.white,
                        ),
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

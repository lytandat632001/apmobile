// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:touch_app/utils/constants.dart';

import 'package:touch_app/utils/icons.dart';
import 'package:touch_app/view/Login_SignUp/LoginButtonWidget.dart';
import 'package:touch_app/view/Login_SignUp/bottomTextView.dart';
import 'package:touch_app/view/Login_SignUp/inputWidget.dart';

import 'package:touch_app/view/Login_SignUp/topTextView.dart';

// import 'package:touch_app/view/auth.dart';

class LoginContentNew extends StatefulWidget {
  const LoginContentNew({
    Key? key,
  }) : super(key: key);
  

  @override
  State<LoginContentNew> createState() => _LoginContentNewState();
}

class _LoginContentNewState extends State<LoginContentNew> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? errorMessage;
  String bottomText1 = 'Don\'t have an account?';
  String bottomText2 = 'Sign Up';
  String title = 'Welcome\nBack';

  Widget forgotPassword() {
    return TextButton(
        onPressed: () {},
        child: const Text(
          'Forgot Password?',
          style: TextStyle(
              color: kLinkColor, fontSize: 18, fontWeight: FontWeight.w800),
        ));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // const currentScreen = Screens.createAccount;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          const Positioned(
            top: 60,
            left: 30,
            child: TopTextView(
              title: 'Welcome\nBack',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Stack(children: <Widget>[
              Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImputWidget(
                        hint: 'Email',
                        hintIcon: closeIcon,
                        obscureText: false,
                        controller: _emailController),
                    ImputWidget(
                        hint: 'Password',
                        hintIcon: closeIcon,
                        obscureText: false,
                        controller: _passwordController),
                    LoginButtonWidget(
                      title: 'Log In',
                 
                      emailController: _emailController,
                      passwordController: _passwordController,
                    ),
                    forgotPassword(),
                  ]),
            ]),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: BottomTextView(
                bottomText1: 'Bạn chưa có tài khoản?',
                bottomText2: ' Đăng ký',
                state: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

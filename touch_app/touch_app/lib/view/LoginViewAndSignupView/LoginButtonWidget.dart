// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:touch_app/utils/constants.dart';
import 'logUserIn.dart';

class LoginButtonWidget extends StatefulWidget {
  const LoginButtonWidget({super.key, required this.title, required this.state, this.emailController, this.passwordController});
  final String title;
  final bool state;
  final emailController ;
  final passwordController ;

  @override
  State<LoginButtonWidget> createState() => _LoginButtonWidgetState();
}

class _LoginButtonWidgetState extends State<LoginButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 130, vertical: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(inputFieldColor),
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape: const StadiumBorder(),
          elevation: 10,
          shadowColor: const Color(inputFieldColor),
        ),
        onPressed: () => widget.state ==true ? logUserIn(context,widget.emailController,widget.passwordController):signUserUp(context,widget.emailController,widget.passwordController),
        child: Text(
          widget.title,
          style: const TextStyle(
            color: kColor,
            fontSize: 23,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

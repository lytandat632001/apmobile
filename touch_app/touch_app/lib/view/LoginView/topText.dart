// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:touch_app/utils/helperFunctions.dart';
import 'package:touch_app/view/LoginView/login_content.dart';
import 'package:touch_app/view/animations/changeScreenAnimation.dart';

class TopText extends StatefulWidget {
  const TopText({super.key});

  @override
  State<TopText> createState() => _TopTextState();
}

class _TopTextState extends State<TopText> {
  @override
  void initState() {
    ChangeScreenAnimation.topTextAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {});
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HelperFunctions.wrapWithAnimatedBuilder(
      animation: ChangeScreenAnimation.topTextAnimation,
      child: Text(
        ChangeScreenAnimation.currentScreen == Screens.createAccount
            ? 'Create\nAccount'
            : 'Welcome\nBack',
        // ignore: prefer_const_constructors
        style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w500,
            backgroundColor: Colors.transparent),
      ),
    );
  }
}

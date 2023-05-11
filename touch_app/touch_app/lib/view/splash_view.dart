import 'dart:async';

import 'package:flutter/material.dart';
import 'package:touch_app/utils/constants.dart';
import 'package:touch_app/view/auth_Page.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    Timer(
        const Duration(seconds: 3),
        () => {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => const AuthPage())),
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => const AuthPage()))
            });
    // Timer(const Duration(seconds: 3), () => {Get.to(const AuthPage())});
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Center(
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: Image.asset('assets/images/Anel.png'),
          ),
        ),
      ),
    );
  }
}

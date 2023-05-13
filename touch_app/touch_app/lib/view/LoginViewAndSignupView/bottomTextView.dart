// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:touch_app/utils/constants.dart';
import 'package:touch_app/view/HomePage/homePageContent.dart';
import 'package:touch_app/view/LoginViewAndSignupView/logincontent.dart';
import 'package:touch_app/view/LoginViewAndSignupView/signupcontent.dart';

class BottomTextView extends StatefulWidget {
  const BottomTextView({
    Key? key,
    required this.bottomText1,
    required this.bottomText2,
    required this.state,
  }) : super(key: key);
  final String bottomText1;
  final String bottomText2;
  final bool state;

  @override
  State<BottomTextView> createState() => _BottomTextViewState();
}

class _BottomTextViewState extends State<BottomTextView> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (widget.state == true) {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const SignupContent()));
          } else {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const LoginContentNew()));
          }
        });
      },
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 16,
              fontFamily: 'Montserrat',
            ),
            children: [
              TextSpan(
                text: widget.bottomText1,
                style: const TextStyle(
                  color: kLinkColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(
                text: widget.bottomText2,
                style: const TextStyle(
                  color: kLinkColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

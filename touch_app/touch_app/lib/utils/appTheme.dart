// ignore_for_file: file_names

import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData appTheme = ThemeData(
    fontFamily: "AlegreyaSans",
    textTheme: const TextTheme(
      // ignore: deprecated_member_use
      headline1: TextStyle(
        fontSize: 38,
        color: Colors.black,
        fontWeight: FontWeight.w500,
      ),
      // ignore: deprecated_member_use
      subtitle1: TextStyle(color: Colors.black, fontSize: 15),
      // ignore: deprecated_member_use
      headline2: TextStyle(
          fontSize: 16, color: Colors.black, fontWeight: FontWeight.w400),
      // ignore: deprecated_member_use
      subtitle2: TextStyle(
          fontSize: 17, color: Colors.black, fontWeight: FontWeight.w500),
      // ignore: deprecated_member_use
      headline3: TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      // ignore: deprecated_member_use
      headline4: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w400, color: Colors.black),
      // ignore: deprecated_member_use
      headline5: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
    ),
  );
}

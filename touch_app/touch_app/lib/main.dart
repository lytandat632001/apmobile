import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touch_app/test.dart';
import 'package:touch_app/utils/constants.dart';
import 'package:touch_app/utils/userProvider.dart';
import 'package:touch_app/view/HomePage/Home.dart';
import 'package:touch_app/view/Login_SignUp/logincontent.dart';
import 'package:touch_app/view/Login_SignUp/signupcontent.dart';
import 'package:touch_app/view/account/account.dart';
import 'package:touch_app/view/manage/managerController.dart';
import 'package:touch_app/view/splash_view.dart';

import 'view/manage/addProduct.dart';

void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => UserProvider(), child: const MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kColor),
      ),
      home: SplashView(),
    );
  }
}


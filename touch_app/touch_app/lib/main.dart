import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touch_app/utils/constants.dart';
import 'package:touch_app/utils/userProvider.dart';
import 'package:touch_app/view/splash_view.dart';

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

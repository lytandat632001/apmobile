// ignore_for_file: file_names
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'login_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void signOut() async{
   await FirebaseAuth.instance.signOut();
   // ignore: use_build_context_synchronously
   Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginView()));
  }
  String check() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return user.email.toString();
    } else {
      return 'null';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(onPressed: signOut, icon: const Icon(Icons.logout)),
          ],
        ),
        body: Center(
          child: Text(
            'Logged In! ${check()}',
            style: const TextStyle(fontWeight: FontWeight.normal),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: file_names, use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:touch_app/view/auth.dart';

void logUserIn(BuildContext context, final emailController,
    final passwordController) async {
  showDialog(
    context: context,
    builder: (context) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    },
  );
  // try {
  //   await Auth().signInWithEmailAndPassword(
  //     emailController.text.trim(), passwordController.text.trim(),
  //   );
  //   Navigator.pop(context);
  // } on FirebaseAuthException catch (e) {
  //   Navigator.pop(context);
  //   if (e.code == 'user-not-found') {
  //     wrongEmailMessage(context);
  //   } else if (e.code == 'wrong-password') {
  //     wrongPasswordMessage(context);
  //   }
  // }
}

Future<void> signUserUp(BuildContext context, final emailController,
    final passwordController) async {
  // try {
  //   await Auth().signUpWithEmailAndPassword(
  //       emailController.text, passwordController.text);
  // } on FirebaseAuthException catch (e) {
  //   print(e);
  // }
}

void wrongEmailMessage(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Incorrect Email!'),
        );
      });
}

void wrongPasswordMessage(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return const AlertDialog(
        title: Text('Incorrect Password!'),
      );
    },
  );
}

// ignore_for_file: file_names, use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';

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

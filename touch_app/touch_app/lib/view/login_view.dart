// ignore_for_file: unused_element

import 'package:flutter/material.dart';

import 'package:touch_app/view/LoginViewAndSignupView/logincontent.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

// topWidget(double size) {
//   return Transform.rotate(
//     angle: -35 * math.pi / 180,
//     child: Container(
//       width: 1.2 * size,
//       height: 1.2 * size,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(150),
//         gradient: const LinearGradient(
//           colors: [
//             kBackgroundColor,
//             Color(kSecondColor),
//           ],
//           begin: Alignment(-0.2, -0.8),
//           end: Alignment.bottomLeft,
//         ),
//       ),
//     ),
//   );
// }

// botWidget(double size) {
//   return Container(
//     width: 1.5 * size,
//     height: 1.5 * size,
//     decoration: const BoxDecoration(
//       shape: BoxShape.circle,
//       gradient: LinearGradient(
//         colors: [
//           Color(kSecondColor),
//           kBackgroundColor,
//         ],
//         begin: Alignment(0.6, -1.1),
//         end: Alignment(0.7, 0.8),
//       ),
//     ),
//   );
// }

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return const Scaffold(
      backgroundColor: Colors.white,
      // body: Stack(
      //   children: [
      //     Positioned(
      //       child: topWidget(size.width),
      //       top: -180,
      //       left: 15,
      //     ),
      //     Positioned(
      //       child: botWidget(size.width),
      //       bottom: -220,
      //       left: -40,
      //     ),
      //     //  if    CenterWidget(size.width),
      //     const LoginContentNew(),

      //     // Navigator.pushReplacementNamed(context, MaterialPageRoute(builder: (_)=>LoginContent()));
      //   ],
      // ),
      body: LoginContentNew(),
    );
  }
}

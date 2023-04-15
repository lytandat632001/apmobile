// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:touch_app/utils/constants.dart';
import 'package:touch_app/utils/helperFunctions.dart';
import 'package:touch_app/view/animations/changeScreenAnimation.dart';

import 'login_content.dart';

// class BottomText extends StatefulWidget {
//   const BottomText({super.key});

//   @override
//   State<BottomText> createState() => _BottomTextState();
// }

// class _BottomTextState extends State<BottomText> {
//   // void page() {
//   //   Get.to(const LoginView());
//   // }

//   @override
//   void initState() {
//     ChangeScreenAnimation.bottomTextAnimation.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         setState(() {});
//       }
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return HelperFunctions.wrapWithAnimatedBuilder(
//       animation: ChangeScreenAnimation.bottomTextAnimation,
//       child: GestureDetector(
//         onTap: () {
//           if (!ChangeScreenAnimation.isPlaying) {
//             // ChangeScreenAnimation.currentScreen == Screens.createAccount
//             ChangeScreenAnimation.forward();
//             // : ChangeScreenAnimation.reverse();
//             ChangeScreenAnimation.currentScreen =
//                 Screens.values[1 - ChangeScreenAnimation.currentScreen.index];
//           }
//         },
//         behavior: HitTestBehavior.opaque,
//         child: Padding(
//           padding: const EdgeInsets.only(top: 10.0),
//           child: RichText(
//             text: TextSpan(
//                 style:
//                     const TextStyle(fontWeight: FontWeight.w800, fontSize: 18),
//                 children: [
//                   TextSpan(
//                     // recognizer: TapGestureRecognizer()
//                     //   ..onTap = () => const LoginView(),
//                     text: ChangeScreenAnimation.currentScreen ==
//                             Screens.createAccount
//                         ? 'Already have no account? '
//                         : 'Don\'t have an account? ',
//                     style: const TextStyle(
//                         color: kLinkColor, fontWeight: FontWeight.w600),
//                   ),
//                   TextSpan(
//                     text: ChangeScreenAnimation.currentScreen ==
//                             Screens.createAccount
//                         ? 'Log In'
//                         : 'Sign Up',
//                     style: const TextStyle(
//                         color: kLinkColor, fontWeight: FontWeight.bold),
//                   ),
//                 ]),
//           ),
//         ),
//       ),
//     );
//     // return InkWell(
//     //   onTap: () {

//     //   },
//     //   child: Text(
//     //     screens == true
//     //         ? 'Already have no account? Log In'
//     //         : 'Don\'t have an account? Sign Up',
//     //     style: const TextStyle(color: kLinkColor, fontWeight: FontWeight.bold),
//     //   ),
//     // );
//   }
// }
class BottomText extends StatefulWidget {
  const BottomText({Key? key}) : super(key: key);

  @override
  State<BottomText> createState() => _BottomTextState();
}

class _BottomTextState extends State<BottomText> {
  @override
  void initState() {
    ChangeScreenAnimation.bottomTextAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {});
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return HelperFunctions.wrapWithAnimatedBuilder(
      animation: ChangeScreenAnimation.bottomTextAnimation,
      child: GestureDetector(
        onTap: () {
          if (!ChangeScreenAnimation.isPlaying) {
            ChangeScreenAnimation.currentScreen == Screens.createAccount
                ? ChangeScreenAnimation.forward()
                : ChangeScreenAnimation.reverse();

            ChangeScreenAnimation.currentScreen =
                Screens.values[1 - ChangeScreenAnimation.currentScreen.index];
          }
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
                  text: ChangeScreenAnimation.currentScreen ==
                          Screens.createAccount
                      ? 'Already have an account? '
                      : 'Don\'t have an account? ',
                  style: const TextStyle(
                    color: kLinkColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextSpan(
                  text: ChangeScreenAnimation.currentScreen ==
                          Screens.createAccount
                      ? 'Log In'
                      : 'Sign Up',
                  style: const TextStyle(
                    color: kLinkColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

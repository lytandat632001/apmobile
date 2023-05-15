// ignore_for_file: use_build_context_synchronously

// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:touch_app/utils/constants.dart';
import 'package:touch_app/utils/icons.dart';
import 'package:touch_app/view/Login_SignUp/LoginButtonWidget.dart';
import 'package:touch_app/view/Login_SignUp/bottomTextView.dart';
import 'package:touch_app/view/Login_SignUp/inputWidget.dart';
import 'package:http/http.dart' as http;
import 'package:touch_app/view/Login_SignUp/signupButtonWidget.dart';

import 'package:touch_app/view/Login_SignUp/topTextView.dart';

class SignupContent extends StatefulWidget {
  const SignupContent({
    Key? key,
  }) : super(key: key);

  @override
  State<SignupContent> createState() => _SignupContentState();
}

class _SignupContentState extends State<SignupContent> {
  final _fullnameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();

  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    // const currentScreen = Screens.createAccount;
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Stack(
        children: [
          const Positioned(
            top: 60,
            left: 30,
            child: TopTextView(
              title: 'Create\nAccount',
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Stack(children: <Widget>[
              Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ImputWidget(
                        hint: 'Họ và tên',
                        hintIcon: closeIcon,
                        obscureText: false,
                        controller: _fullnameController),
                    ImputWidget(
                        hint: 'Email',
                        hintIcon: closeIcon,
                        obscureText: false,
                        controller: _emailController),
                    ImputWidget(
                        hint: 'Password',
                        hintIcon: closeIcon,
                        obscureText: true,
                        controller: _passwordController),
                    ImputWidget(
                        hint: 'Số điện thoại',
                        hintIcon: closeIcon,
                        obscureText: false,
                        controller: _phoneController),
                    ImputWidget(
                        hint: 'Địa chỉ',
                        hintIcon: closeIcon,
                        obscureText: false,
                        controller: _addressController),
                    SignUpButton(
                      title: 'Đăng ký',
                      fullnameController: _fullnameController,
                      emailController: _emailController,
                      passwordController: _passwordController,
                      phoneController: _phoneController,
                      addressController: _addressController,
                    ),
                  ]),
            ]),
          ),
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: BottomTextView(
                  bottomText1: 'Bạn đã có  tài khoản?',
                  bottomText2: ' Đăng nhập',
                  state: false),
            ),
          ),
        ],
      ),
    );
  }

  Widget inputField(String hint, Icon hintIcon, bool obscureText, controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 10),
      child: SizedBox(
        height: 55,
        child: Material(
          elevation: 10,
          borderRadius: BorderRadius.circular(20),
          shadowColor: Colors.black87,
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(fontSize: 18),
              filled: true,
              fillColor: const Color(inputFieldColor),
              border: OutlineInputBorder(
                borderSide: BorderSide.none,
                borderRadius: BorderRadius.circular(20),
              ),
              suffixIconColor: kPrimaryColor,
              suffixIcon: hintIcon,
            ),
          ),
        ),
      ),
    );
  }

  // Widget signupButton(String title, bool state) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 130, vertical: 20),
  //     child: ElevatedButton(
  //       style: ElevatedButton.styleFrom(
  //         backgroundColor: const Color(inputFieldColor),
  //         padding: const EdgeInsets.symmetric(vertical: 10),
  //         shape: const StadiumBorder(),
  //         elevation: 10,
  //         shadowColor: const Color(inputFieldColor),
  //       ),
  //       onPressed: () {
  //         child:
  //         Text(
  //           title,
  //           style: const TextStyle(
  //             color: kColor,
  //             fontSize: 23,
  //             fontWeight: FontWeight.w500,
  //           ),
  //         );
  //       },
  //       child: null,
  //       //=>  signUserUp(),
  //     ),
  //   );
  // }

  // Widget orDivder() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 100),
  //     child: Row(
  //       children: [
  //         Flexible(
  //           child: Container(
  //             height: 1,
  //             color: kPrimaryColor,
  //           ),
  //         ),
  //         const Padding(
  //           padding: EdgeInsets.symmetric(horizontal: 15),
  //           child: Text(
  //             'or',
  //             style: TextStyle(
  //               color: kColor,
  //               fontSize: 16,
  //               fontWeight: FontWeight.w400,
  //             ),
  //           ),
  //         ),
  //         Flexible(
  //           child: Container(
  //             height: 1,
  //             color: kPrimaryColor,
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget logos() {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(vertical: 5),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         Image.asset('assets/images/google.png', width: 40),
  //         const SizedBox(
  //           width: 70,
  //         ),
  //         Image.asset(
  //           'assets/images/facebook.png',
  //           width: 40,
  //         )
  //       ],
  //     ),
  //   );
  // }

  Widget forgotPassword() {
    return TextButton(
        onPressed: () {},
        child: const Text(
          'Forgot Password?',
          style: TextStyle(
              color: kLinkColor, fontSize: 18, fontWeight: FontWeight.w800),
        ));
  }

  void wrongEmailMessage() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text('Incorrect Email!'),
          );
        });
  }

  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Incorrect Password!'),
        );
      },
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}

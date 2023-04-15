// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:touch_app/utils/constants.dart';
import 'package:touch_app/utils/helperFunctions.dart';
import 'package:touch_app/utils/icons.dart';
import 'package:touch_app/view/LoginView/topText.dart';
import 'package:touch_app/view/animations/changeScreenAnimation.dart';
import 'package:touch_app/view/auth.dart';
import 'bottomText.dart';

enum Screens { createAccount, welcomeBack }

class LoginContent extends StatefulWidget {
  const LoginContent({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent>
    with TickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? errorMessage;
  late List<Widget> createAccountContent = [];
  late List<Widget> loginContent = [];


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

  Widget loginButton(String title, bool state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 130, vertical: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(inputFieldColor),
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape: const StadiumBorder(),
          elevation: 10,
          shadowColor: const Color(inputFieldColor),
        ),
        onPressed: () => state ? signUserIn() : signUserUp(),
        child: Text(
          title,
          style: const TextStyle(
            color: kColor,
            fontSize: 23,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget orDivder() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 100),
      child: Row(
        children: [
          Flexible(
            child: Container(
              height: 1,
              color: kPrimaryColor,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              'or',
              style: TextStyle(
                color: kColor,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Flexible(
            child: Container(
              height: 1,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget logos() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset('assets/images/google.png', width: 40),
          const SizedBox(
            width: 70,
          ),
          Image.asset(
            'assets/images/facebook.png',
            width: 40,
          )
        ],
      ),
    );
  }

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

 

  Future<void> signUserUp() async {
    try {
      await Auth().signUpWithEmailAndPassword(
          _emailController.text, _passwordController.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

 void signUserIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'user-not-found') {
        wrongEmailMessage();
      } else if (e.code == 'wrong-password') {
        wrongPasswordMessage();
      }
    }
  }

  @override
  void dispose() {
    print('debug');
    _emailController.dispose();
    _passwordController.dispose();
    ChangeScreenAnimation.dispose();
    super.dispose();
  }


  @override
  void initState() {
    print('initState');
    super.initState();
    createAccountContent = [
      inputField('Email', closeIcon, false, _emailController),
      inputField('Password', closeIcon, true, _passwordController),
      loginButton('Sign Up', false),
      orDivder(),
      logos(),
    ];
    loginContent = [
      inputField('Email', closeIcon, false, _emailController),
      inputField('Password', closeIcon, true, _passwordController),
      loginButton(
        'Log In',
        true,
      ),
      forgotPassword(),
    ];
    ChangeScreenAnimation.initState(
        vsync: this,
        loginItems: loginContent.length,
        createAccountItems: createAccountContent.length);
    for (var i = 0; i < createAccountContent.length; i++) {
      createAccountContent[i] = HelperFunctions.wrapWithAnimatedBuilder(
          animation: ChangeScreenAnimation.createAccountAnimations[i],
          child: createAccountContent[i]);
    }
    for (var i = 0; i < loginContent.length; i++) {
      loginContent[i] = HelperFunctions.wrapWithAnimatedBuilder(
          animation: ChangeScreenAnimation.loginAnimations[i],
          child: loginContent[i]);
    }
  }

  // 

@override
void didUpdateWidget(LoginContent oldWidget){
    super.didUpdateWidget(oldWidget);
}

  // @mustCallSuper
  // @protected
  // void didChangeDependencies() {
  //   createAccountContent = [
  //     inputField('Email', closeIcon, false, _emailController),
  //     inputField('Password', closeIcon, true, _passwordController),
  //     loginButton('Sign Up', false),
  //     orDivder(),
  //     logos(),
  //   ];
  //   loginContent = [
  //     inputField('Email', closeIcon, false, _emailController),
  //     inputField('Password', closeIcon, true, _passwordController),
  //     loginButton(
  //       'Log In',
  //       true,
  //     ),
  //     forgotPassword(),
  //   ];
  //   ChangeScreenAnimation.initState(
  //       vsync: this,
  //       loginItems: loginContent.length,
  //       createAccountItems: createAccountContent.length);
  //   for (var i = 0; i < createAccountContent.length; i++) {
  //     createAccountContent[i] = HelperFunctions.wrapWithAnimatedBuilder(
  //         animation: ChangeScreenAnimation.createAccountAnimations[i],
  //         child: createAccountContent[i]);
  //   }
  //   for (var i = 0; i < loginContent.length; i++) {
  //     loginContent[i] = HelperFunctions.wrapWithAnimatedBuilder(
  //         animation: ChangeScreenAnimation.loginAnimations[i],
  //         child: loginContent[i]);
  //   }
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    // const currentScreen = Screens.createAccount;
    return Stack(
      children: [
        const Positioned(
          top: 60,
          left: 30,
          child: TopText(),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Stack(children: <Widget> [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: createAccountContent,
              // children: currentScreen == Screens.welcomeBack
              //     ? [
              //         inputField('Email', closeIcon, false, _emailController),
              //         inputField(
              //             'Password', closeIcon, true, _passwordController),
              //         loginButton('Sign Up', false),
              //         orDivder(),
              //         logos(),
              //       ]
              //     : [
              //         inputField('Email', closeIcon, false, _emailController),
              //         inputField(
              //             'Password', closeIcon, true, _passwordController),
              //         loginButton(
              //           'Log In',
              //           true,
              //         ),
              //         forgotPassword(),
              //       ]
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: loginContent,
            ),
          ]),
        ),
        const Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: BottomText(),
          ),
        ),
      ],
    );
  }
}

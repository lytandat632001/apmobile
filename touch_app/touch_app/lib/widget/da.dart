import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:http/http.dart';
import 'package:touch_app/a.dart';

import 'package:http/http.dart' as http;
import 'package:touch_app/data/dataProduct.dart';
import 'package:touch_app/model/product.dart';
import 'package:touch_app/model/user.dart';
import 'package:touch_app/utils/constants.dart';
import 'package:touch_app/utils/icons.dart';
import 'package:touch_app/view/HomePage.dart';
import 'package:touch_app/view/HomePage/Home.dart';
// import 'package:touch_app/view/LoginViewAndSignupView/LoginButtonWidget.dart';
// import 'dart:io';

import 'package:touch_app/view/LoginViewAndSignupView/inputWidget.dart';
import 'package:touch_app/view/LoginViewAndSignupView/logincontent.dart';

class Da extends StatefulWidget {
  const Da({super.key});

  @override
  State<Da> createState() => _DaState();
}

class _DaState extends State<Da> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late Welcome userAPI;
  bool isDataLoaded = false;
  String errorMsg = "";

  // Future<UserAPI> getDataFromAPI() async {
  //   Uri url = Uri.parse("http://10.0.8.1:8080/api/users");
  //   var response = await http.get(url);
  //   if (response.statusCode == HttpStatus.ok) {
  //     UserAPI userAPI = userAPIFromJson(response.body);
  //     return userAPI;
  //   } else {
  //     errorMsg = '${response.statusCode}:${response.body}';
  //     return UserAPI(data: []);
  //   }
  // }
  Future<Welcome> getDataFromAPI() async {
    Uri url = Uri.parse(
        "https://jatinderji.github.io/users_pets_api/users_pets.json");
    var response = await http.get(url);
    if (response.statusCode == HttpStatus.ok) {
      Welcome userAPI = welcomeFromJson(response.body);
      return userAPI;
    } else {
      errorMsg = '${response.statusCode}:${response.body}';
      return Welcome(data: []);
    }
  }

  assignData() async {
    userAPI = await getDataFromAPI();
    setState(() {
      isDataLoaded = true;
    });
  }

  @override
  void initState() {
    assignData();
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

//  Future< void> signUserIn(String email, String password) async {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return const Center(
//           child: CircularProgressIndicator(),
//         );
//       },
//     );
//     try {
//       var response = post(
//           Uri.parse(
//               'https://jatinderji.github.io/users_pets_api/users_pets.json'),
//           body: {
//             'userName': email,
//             'petName': password,
//           });
//           if (response.statusCode == HttpStatus.ok) {

//           } else {

//           }
//     } catch (e) {
//       print(e.toString());
//     }
//   }

  @override
  Widget build(BuildContext context) {
    User user;
    return Scaffold(
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 130, vertical: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(inputFieldColor),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  shape: const StadiumBorder(),
                  elevation: 10,
                  shadowColor: const Color(inputFieldColor),
                ),
                onPressed: () {
                  try {
                    for (var element in userAPI.data) {
                      if (_emailController.text.toString().toLowerCase() ==
                              element.userName.toString().toLowerCase() &&
                          _passwordController.text.toString().toLowerCase() ==
                              element.petName.toString().toLowerCase()) {
                        // user = User(
                        //     idUser: 1,
                        //     email: element.petName.toString(),
                        //     password: element.petName.toString(),
                        //     fullname: "Lý Tấn Đạt",
                        //     phone: "0974399560",
                        //     address: "Đồng Nai");
                        // userlist.add(user);
                        break;
                      } else {
                        var snackBar = SnackBar(
                            backgroundColor: Colors.transparent,
                            duration: const Duration(seconds: 3),
                            content: AwesomeSnackbarContent(
                                title: "Lỗi đăng nhập",
                                message:
                                    "Email hoặc tài khoản đăng nhập không chính xác",
                                contentType: ContentType.success));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    }

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeProduct()),
                    );
                  } catch (e) {
                    print(e.toString());
                  }
                },
                // onPressed: () => widget.state ==true ? logUserIn(context,widget.emailController,widget.passwordController):signUserUp(context,widget.emailController,widget.passwordController),
                child: const Text(
                  'dang nhap',
                  style: TextStyle(
                    color: kColor,
                    fontSize: 23,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ]),
    );
  }
}

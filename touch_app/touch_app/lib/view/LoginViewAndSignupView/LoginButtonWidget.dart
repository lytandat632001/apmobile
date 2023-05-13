// ignore_for_file: file_names, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:ffi';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import 'package:http/http.dart' as http;

import 'package:touch_app/a.dart';
import 'package:touch_app/data/dataProduct.dart';
import 'package:touch_app/model/user.dart';
import 'package:touch_app/testapi.dart';
import 'package:touch_app/utils/constants.dart';
import 'package:touch_app/view/HomePage/Home.dart';
import 'logUserIn.dart';

class LoginButtonWidget extends StatefulWidget {
  const LoginButtonWidget(
      {super.key,
      required this.title,
      required this.state,
      this.emailController,
      this.passwordController});
  final String title;
  final bool state;
  final emailController;
  final passwordController;

  @override
  State<LoginButtonWidget> createState() => _LoginButtonWidgetState();
}

class _LoginButtonWidgetState extends State<LoginButtonWidget> {
  // late Welcome userAPI;
  // bool isDataLoaded = false;
  // String errorMsg = "";
  // Future<Welcome> getDataFromAPI() async {
  //   Uri url = Uri.parse(
  //       "https://api-datly.phamthanhnam.com/api/users/");
  //   var response = await http.get(url);
  //   if (response.statusCode == HttpStatus.ok) {
  //     Welcome userAPI = welcomeFromJson(response.body);
  //     return userAPI;
  //   } else {
  //     errorMsg = '${response.statusCode}:${response.body}';
  //     return Welcome(data: []);
  //   }
  // }

  // assignData() async {
  //   userAPI = await getDataFromAPI();
  //   setState(() {
  //     isDataLoaded = true;
  //   });
  // }

  // @override
  // void initState() {
  //   assignData();
  //   super.initState();
  // }

//API

  late List<UserApi> userAPI;
  late List<UserApi> userAPIemty;
  bool isDataLoaded = false;
  String errorMsg = "";
  static Future<UserApi?> getDataCustomer(String token) async {
    var response = await http
        .get(Uri.parse('https://tracking.irace.vn/api/v1/app/users'), headers: {
      "Accept": "application/json",
      "content-type": "application/json",
      'Authorization': 'Bearer ${Get.find<UserApi>()}'
    });
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);

      return null; //Future<UserApi>.value(UserApi.fromJson(data[]));
    }
  }

  assignData() async {
    userAPI = (getDataCustomer) as List<UserApi>;
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
  Widget build(BuildContext context) {
    User user;
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
        onPressed: () {
          try {
            userAPI.forEach((element) {
              for (var element in userAPI) {
                if (widget.emailController.text.toString().toLowerCase() ==
                        element.email.toString().toLowerCase() &&
                    widget.passwordController.text.toString().toLowerCase() ==
                        element.password.toString().toLowerCase()) {
                  user = User(
                      idUser: element.id,
                      email: element.email.toString(),
                      password: element.password.toString(),
                      fullname: element.fullname,
                      phone: element.phone,
                      address: element.address);
                  // user.idUser = 1;
                  // user.email = element.userName.toString();
                  // user.password = element.petName.toString();
                  // user.fullname = "Lý Tấn Đạt";
                  // user.phone = "0974399560";
                  userlist.add(user);

                  print(userlist[1].address);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomeProduct()),
                  );
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
                break;
              }
            });
            // for (var element in userAPI) {
            //   if (widget.emailController.text.toString().toLowerCase() ==
            //           element..toString().toLowerCase() &&
            //       widget.passwordController.text.toString().toLowerCase() ==
            //           element.petName.toString().toLowerCase()) {
            //     user = User(
            //         idUser: 1,
            //         email: element.userName.toString(),
            //         password: element.petName.toString(),
            //         fullname: "Lý Tấn Đạt",
            //         phone: "0974399560",
            //         address: "Đồng Nai");
            //     // user.idUser = 1;
            //     // user.email = element.userName.toString();
            //     // user.password = element.petName.toString();
            //     // user.fullname = "Lý Tấn Đạt";
            //     // user.phone = "0974399560";
            //     userlist.add(user);

            //     print(userlist[1].address);
            //     Navigator.push(
            //       context,
            //       MaterialPageRoute(builder: (context) => const HomeProduct()),
            //     );
            //     break;
            //   } else {
            //     var snackBar = SnackBar(
            //         backgroundColor: Colors.transparent,
            //         duration: const Duration(seconds: 3),
            //         content: AwesomeSnackbarContent(
            //             title: "Lỗi đăng nhập",
            //             message:
            //                 "Email hoặc tài khoản đăng nhập không chính xác",
            //             contentType: ContentType.success));
            //     ScaffoldMessenger.of(context).showSnackBar(snackBar);
            //   }
            //   break;
            // }
          } catch (e) {
            print(e.toString());
          }
        },
        // onPressed: () => widget.state ==true ? logUserIn(context,widget.emailController,widget.passwordController):signUserUp(context,widget.emailController,widget.passwordController),
        child: Text(
          widget.title,
          style: const TextStyle(
            color: kColor,
            fontSize: 23,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:touch_app/utils/constants.dart';
import 'package:touch_app/utils/icons.dart';
import 'package:touch_app/utils/userProvider.dart';
import 'package:touch_app/view/LoginViewAndSignupView/inputWidget.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  dynamic user;

  Future<void> fetchUsers(int? userID) async {
    var apiUrl = 'https://api-datly.phamthanhnam.com/api/users/$userID';

    try {
      var response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        setState(() {
          user = jsonDecode(response.body);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Lay thành công')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Không thể lấy danh sách sản phẩm')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Đã xảy ra lỗi')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    int? userId = userProvider.userId;
    fetchUsers(userId);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _fullnameController = TextEditingController();
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    final _phoneController = TextEditingController();
    final _addressController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Tài khoản",
          style: TextStyle(color: kColor),
        ),
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        elevation: 0.2,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.close,
                color: kColor,
              ))
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Text(user != null ? user['email'] : 'Kh lay dc',
                  style: const TextStyle(color: kColor, fontSize: 22)),
              Padding(
                padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                child: Container(
                  height: size.height * 0.6,
                  width: size.width,
                  decoration: const BoxDecoration(
                      border: Border(
                          bottom: BorderSide(width: 0.3, color: Colors.black))),
                  child: Column(
                    children: [
                      Text("Đơn đặt hàng",
                          style: TextStyle(color: kColor, fontSize: 22))
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: size.width,
                child: Column(
                  children: [
                    const Text(
                      "Thông tin tài khoản",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 23,
                          fontWeight: FontWeight.w400),
                    ),
                    ImputWidget(
                        hint: user['fullname'],
                        hintIcon: closeIcon,
                        obscureText: false,
                        controller: _fullnameController),
                    ImputWidget(
                        hint: user['email'],
                        hintIcon: closeIcon,
                        obscureText: false,
                        controller: _emailController),
                    ImputWidget(
                        hint: user['password'],
                        hintIcon: closeIcon,
                        obscureText: false,
                        controller: _passwordController),
                    ImputWidget(
                        hint: user['password'],
                        hintIcon: closeIcon,
                        obscureText: true,
                        controller: _passwordController),
                    ImputWidget(
                        hint: user['phone'],
                        hintIcon: closeIcon,
                        obscureText: false,
                        controller: _phoneController),
                    ImputWidget(
                        hint: user['address'],
                        hintIcon: closeIcon,
                        obscureText: false,
                        controller: _addressController),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(inputFieldColor),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        shape: const StadiumBorder(),
                        elevation: 10,
                        shadowColor: const Color(inputFieldColor),
                      ),
                      onPressed: () {
                        // setState(() async {
                        //   print(userId);
                        //   print(token);

                        //   try {
                        //     final userData = await getUserData(userId!, token!);
                        //     print(userData); // In dữ liệu người dùng từ API

                        //     // Cập nhật dữ liệu người dùng vào các TextEditingControllers
                        //     _fullnameController.text =
                        //         userData['fullname'] ?? '';
                        //     _emailController.text = userData['email'] ?? '';
                        //     _passwordController.text =
                        //         userData['password'] ?? '';
                        //     _phoneController.text = userData['phone'] ?? '';
                        //     _addressController.text = userData['address'] ?? '';
                        //   } catch (e) {
                        //     print('Error: $e');
                        //   }
                        // });

                        // setState(() {
                        //   print(userId);
                        //   print(token);

                        //   // if (_fullnameController.text.toString().isEmpty) {
                        //   //   userlist[1].fullname = userlist[1].fullname;
                        //   // } else {
                        //   //   userlist[1].fullname =
                        //   //       _fullnameController.text.toString();
                        //   // }

                        //   // if (_emailController.text.toString().isEmpty) {
                        //   //   userlist[1].email = userlist[1].email;
                        //   // } else {
                        //   //   userlist[1].email =
                        //   //       _emailController.text.toString();
                        //   // }
                        //   // if (_passwordController.text.toString().isEmpty) {
                        //   //   userlist[1].password = userlist[1].password;
                        //   // } else {
                        //   //   userlist[1].password =
                        //   //       _passwordController.text.toString();
                        //   // }
                        //   // if (_phoneController.text.toString().isEmpty) {
                        //   //   userlist[1].phone = userlist[1].phone;
                        //   // } else {
                        //   //   userlist[1].phone =
                        //   //       _phoneController.text.toString();
                        //   // }
                        //   // if (_addressController.text.toString().isEmpty) {
                        //   //   userlist[1].address = userlist[1].address;
                        //   // } else {
                        //   //   userlist[1].address =
                        //   //       _addressController.text.toString();
                        //   // }
                        // });
                      },
                      // onPressed: () => widget.state ==true ? logUserIn(context,widget.emailController,widget.passwordController):signUserUp(context,widget.emailController,widget.passwordController),
                      child: const Text(
                        "Cập nhật",
                        style: TextStyle(
                          color: kColor,
                          fontSize: 23,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

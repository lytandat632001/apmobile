import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:touch_app/utils/constants.dart';
import 'package:touch_app/utils/icons.dart';
import 'package:touch_app/utils/userProvider.dart';

import '../Login_SignUp/inputWidget.dart';

class EditUser extends StatefulWidget {
  const EditUser({
    super.key,
    required this.data,
  });
  final dynamic data;

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _fullnameController = TextEditingController();
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    String passwordCurrcent =
        widget.data != null ? widget.data['password'] : '';
    final _phoneController = TextEditingController();
    final _addressController = TextEditingController();
    _fullnameController.text =
        widget.data != null ? widget.data['fullname'] : '';
    _emailController.text = widget.data != null ? widget.data['email'] : '';
    _phoneController.text = widget.data != null ? widget.data['phone'] : '';
    _addressController.text = widget.data != null ? widget.data['address'] : '';

    Future<void> updateUserData(userId) async {
      // final userProvider = Provider.of<UserProvider>(context, listen: false);
      // final userId = userProvider.userId;
      // final token = userProvider.token;

      final url = 'https://api-datly.phamthanhnam.com/api/users/$userId';

      final body = {
        'fullname': _fullnameController.text,
        'email': _emailController.text,
        'password': passwordCurrcent,
        'phone': _phoneController.text,
        'address': _addressController.text,
      };

      final headers = {
        'Content-Type': 'application/json',
      };

      try {
        final response = await http.put(
          Uri.parse(url),
          headers: headers,
          body: jsonEncode(body),
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cập nhật thành công')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Không thể cập nhật thông tin tài khoản')),
          );
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Đã xảy ra lỗi')),
        );
      }
    }

    // Future<void> ChangePassword() async {

    //   final url =
    //       'https://api-datly.phamthanhnam.com/api/users/$userId/$passwordCurrcent';

    //   final body = {'password': passwordCurrcent};

    //   final headers = {
    //     'Content-Type': 'application/json',

    //   };

    //   try {
    //     final response = await http.put(
    //       Uri.parse(url),
    //       headers: headers,
    //       body: jsonEncode(body),
    //     );

    //     if (response.statusCode == 200) {
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         const SnackBar(content: Text('Cập nhật thành công')),
    //       );
    //     } else {
    //       ScaffoldMessenger.of(context).showSnackBar(
    //         SnackBar(content: Text('Không thể cập nhật thông tin tài khoản')),
    //       );
    //     }
    //   } catch (error) {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(content: Text('Đã xảy ra lỗi')),
    //     );
    //   }
    // }

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
              Text(widget.data != null ? widget.data['email'] : 'Kh lay dc',
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
                child: SingleChildScrollView(
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
                          hint: widget.data != null
                              ? widget.data['fullname']
                              : "fullname",
                          hintIcon: closeIcon,
                          obscureText: false,
                          controller: _fullnameController),
                      ImputWidget(
                          hint: widget.data != null
                              ? widget.data['email']
                              : "email",
                          hintIcon: closeIcon,
                          obscureText: false,
                          controller: _emailController),
                      // ImputWidget(
                      //     hint: user != null ? user['password'] : "password",
                      //     hintIcon: closeIcon,
                      //     obscureText: false,
                      //     controller: _passwordController),
                      ImputWidget(
                          hint: widget.data != null
                              ? widget.data['phone']
                              : "phone",
                          hintIcon: closeIcon,
                          obscureText: false,
                          controller: _phoneController),
                      ImputWidget(
                          hint: widget.data != null
                              ? widget.data['address']
                              : "address",
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
                          updateUserData(widget.data['id']);
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

                      Container(
                        child: Column(
                          children: [
                            ImputWidget(
                                hint: 'password',
                                hintIcon: closeIcon,
                                obscureText: false,
                                controller: _passwordController),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(inputFieldColor),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                shape: const StadiumBorder(),
                                elevation: 10,
                                shadowColor: const Color(inputFieldColor),
                              ),
                              onPressed: () {
                                //    ChangePassword();
                              },
                              // onPressed: () => widget.state ==true ? logUserIn(context,widget.emailController,widget.passwordController):signUserUp(context,widget.emailController,widget.passwordController),
                              child: const Text(
                                "Thay đổi mật khẩu",
                                style: TextStyle(
                                  color: kColor,
                                  fontSize: 23,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

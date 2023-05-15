// ignore_for_file: file_names, prefer_typing_uninitialized_variables, use_build_context_synchronously

import 'dart:convert';
// import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:touch_app/utils/constants.dart';
import 'package:touch_app/utils/userProvider.dart';
import 'package:touch_app/view/HomePage/Home.dart';
import 'package:touch_app/view/manage/managerController.dart';

class SignUpButton extends StatefulWidget {
  SignUpButton({
    super.key,
    required this.title,
    this.fullnameController,
    this.emailController,
    this.passwordController,
    this.phoneController,
    this.addressController,
  });
  final String title;
  final fullnameController;
  final emailController;
  final passwordController;
  final phoneController;
  final addressController;

  @override
  State<SignUpButton> createState() => _SignUpButtonState();
}

class _SignUpButtonState extends State<SignUpButton> {
  Future<void> signUpUser() async {
    String fullname = widget.fullnameController.text;
    String email = widget.emailController.text;
    String password = widget.passwordController.text;
    String phone = widget.phoneController.text;
    String address = widget.addressController.text;
    final response = await http.post(
      Uri.parse('https://api-datly.phamthanhnam.com/api/users/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'fullname': fullname,
        'email': email,
        'password': password,
        'phone': phone,
        'address': address,
      }),
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đăng ký thành công')),
      );

      var apiUrl = 'https://api-datly.phamthanhnam.com/api/auth/login';
      var loginData = {'email': email, 'password': password};
      try {
        var response = await http.post(
          Uri.parse(apiUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(loginData),
        );

        if (response.statusCode == 200) {
          var responseData = jsonDecode(response.body);

          // Lưu thông tin người dùng vào ứng dụng hoặc thực hiện các thao tác khác
          var userId = responseData['userId'];
          var token = responseData['token'];
          UserProvider userProvider =
              Provider.of<UserProvider>(context, listen: false);
          userProvider.setUserId(userId);
          userProvider.setToken(token);
          print(userId);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Đăng nhập thành công')),
          );

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const HomeProduct()));

          // Tạo một đối tượng UserModel và gán giá trị

          // Hiển thị thông tin người dùng lên giao diện

          // Tiếp tục xử lý hoặc điều hướng tùy theo kết quả đăng nhập
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Đăng nhập thất bại')),
          );
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đã xảy ra lỗi')),
        );
      }
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Đăng ký th')),
      );
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Lỗi');
    }
  }

  Future<void> login(BuildContext context) async {}

  @override
  Widget build(BuildContext context) {
    // UserProvider userProvider = Provider.of<UserProvider>(context);
    // int? userId = userProvider.userId;
    // String? token = userProvider.token;

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
          signUpUser();
          login(context);
        },
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

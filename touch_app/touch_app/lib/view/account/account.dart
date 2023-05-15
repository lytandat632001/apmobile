import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:touch_app/utils/constants.dart';
import 'package:touch_app/utils/icons.dart';
import 'package:touch_app/utils/userProvider.dart';

import '../Login_SignUp/inputWidget.dart';

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
    String passwordCurrcent = user != null ? user['password'] : '';
    final _phoneController = TextEditingController();
    final _addressController = TextEditingController();
    _fullnameController.text = user != null ? user['fullname'] : '';
    _emailController.text = user != null ? user['email'] : '';
    _phoneController.text = user != null ? user['phone'] : '';
    _addressController.text = user != null ? user['address'] : '';

    Future<void> updateUserData() async {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final userId = userProvider.userId;
      final token = userProvider.token;

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
        'Authorization': 'Bearer $token',
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

    Future<void> ChangePassword() async {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final userId = userProvider.userId;
      final token = userProvider.token;

      final url =
          'https://api-datly.phamthanhnam.com/api/users/$userId/$passwordCurrcent';

      final body = {'password': passwordCurrcent};

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
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
                          hint: user != null ? user['fullname'] : "fullname",
                          hintIcon: closeIcon,
                          obscureText: false,
                          controller: _fullnameController),
                      ImputWidget(
                          hint: user != null ? user['email'] : "email",
                          hintIcon: closeIcon,
                          obscureText: false,
                          controller: _emailController),
                      // ImputWidget(
                      //     hint: user != null ? user['password'] : "password",
                      //     hintIcon: closeIcon,
                      //     obscureText: false,
                      //     controller: _passwordController),
                      ImputWidget(
                          hint: user != null ? user['phone'] : "phone",
                          hintIcon: closeIcon,
                          obscureText: false,
                          controller: _phoneController),
                      ImputWidget(
                          hint: user != null ? user['address'] : "address",
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
                          updateUserData();
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
                                ChangePassword();
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

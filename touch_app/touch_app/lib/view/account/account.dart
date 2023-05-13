import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:touch_app/data/dataProduct.dart';
import 'package:touch_app/utils/constants.dart';
import 'package:touch_app/utils/icons.dart';
import 'package:touch_app/view/LoginViewAndSignupView/inputWidget.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
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
              Text('${userlist[1].fullname}',
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
                        hint: ' ${userlist[1].fullname}',
                        hintIcon: closeIcon,
                        obscureText: false,
                        controller: _fullnameController),
                    ImputWidget(
                        hint: ' ${userlist[1].email}',
                        hintIcon: closeIcon,
                        obscureText: false,
                        controller: _emailController),
                    ImputWidget(
                        hint: 'password',
                        hintIcon: closeIcon,
                        obscureText: true,
                        controller: _passwordController),
                    ImputWidget(
                        hint: ' ${userlist[1].phone}',
                        hintIcon: closeIcon,
                        obscureText: false,
                        controller: _phoneController),
                    ImputWidget(
                        hint: ' ${userlist[1].address}',
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
                        setState(() {
                          // _fullnameController.addListener(() {
                          //   userlist[1].fullname =
                          //       _fullnameController.text.toString();
                          //   print(userlist[1].fullname);
                          // });
                          // _emailController.addListener(() {
                          //   userlist[1].email =
                          //       _emailController.text.toString();
                          // });
                          // _passwordController.addListener(() {
                          //   userlist[1].password =
                          //       _passwordController.text.toString();
                          // });
                          // _phoneController.addListener(() {
                          //   userlist[1].phone = userlist[1].phone =
                          //       _phoneController.text.toString();
                          // });
                          // _addressController.addListener(() {
                          //   userlist[1].address =
                          //       _addressController.text.toString();
                          //   print(userlist[1].address);

                          // });
                          if (_fullnameController.text.toString().isEmpty) {
                            userlist[1].fullname = userlist[1].fullname;
                          } else {
                            userlist[1].fullname =
                                _fullnameController.text.toString();
                          }

                          if (_emailController.text.toString().isEmpty) {
                            userlist[1].email = userlist[1].email;
                          } else {
                            userlist[1].email =
                                _emailController.text.toString();
                          }
                          if (_passwordController.text.toString().isEmpty) {
                            userlist[1].password = userlist[1].password;
                          } else {
                            userlist[1].password =
                                _passwordController.text.toString();
                          }
                          if (_phoneController.text.toString().isEmpty) {
                            userlist[1].phone = userlist[1].phone;
                          } else {
                            userlist[1].phone =
                                _phoneController.text.toString();
                          }
                          if (_addressController.text.toString().isEmpty) {
                            userlist[1].address = userlist[1].address;
                          } else {
                            userlist[1].address =
                                _addressController.text.toString();
                          }
                          // userlist[1].fullname =
                          //     _fullnameController.text.toString();
                          // userlist[1].email = _emailController.text.toString();
                          // userlist[1].password =
                          //     _passwordController.text.toString();
                          // userlist[1].phone = _phoneController.text.toString();
                          // userlist[1].address =
                          //     _addressController.text.toString();
                        });

                        print(userlist[1].address);

                        // setState(() {
                        //   _addressController.addListener(() {
                        //     String a = _addressController.text.toString();
                        //     userlist[1].address = a;
                        //   });
                        //   print(userlist[1].address);
                        // });
                        // print(userlist[1].address);
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

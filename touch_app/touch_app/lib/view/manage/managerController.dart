import 'package:flutter/material.dart';
import 'package:touch_app/utils/constants.dart';
import 'package:touch_app/view/Login_SignUp/logincontent.dart';
import 'package:touch_app/view/manage/addProduct.dart';
import 'package:touch_app/view/manage/editUserPage.dart';
import 'package:touch_app/view/manage/listEditProduct.dart';

import '../../data/API.dart';
import 'order.dart';

class ManagerController extends StatefulWidget {
  const ManagerController({super.key});

  @override
  State<ManagerController> createState() => _ManagerControllerState();
}

class _ManagerControllerState extends State<ManagerController> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: size.width * 0.5,
                color: Colors.blue,
                child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const AddProduct()));
                    },
                    child: Text(
                      'Thêm sản phẩm',
                      style: TextStyle(
                          color: kBackgroundColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              Container(
                width: size.width * 0.5,
                color: Colors.blue,
                child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const ListEditProduct()));
                    },
                    child: Text(
                      'Quản lý sản phẩm',
                      style: TextStyle(
                          color: kBackgroundColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              Container(
                width: size.width * 0.5,
                color: Colors.blue,
                child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const EditUserPage()));
                    },
                    child: Text(
                      'Quản lý người dùng',
                      style: TextStyle(
                          color: kBackgroundColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              Container(
                width: size.width * 0.5,
                color: Colors.blue,
                child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const OrderPage()));
                    },
                    child: Text(
                      'Quản lý đơn hàng',
                      style: TextStyle(
                          color: kBackgroundColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )),
              ),
              Container(
                width: size.width * 0.5,
                color: Colors.blue,
                child: TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginContentNew()));
                    },
                    child: Text(
                      'Quay lại đăng nhập',
                      style: TextStyle(
                          color: kBackgroundColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

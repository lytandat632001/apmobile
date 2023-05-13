import 'package:flutter/material.dart';
import 'package:touch_app/utils/constants.dart';

class productManage extends StatefulWidget {
  const productManage({super.key});

  @override
  State<productManage> createState() => _productManageState();
}

class _productManageState extends State<productManage> {
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
                    onPressed: () {},
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
                    onPressed: () {},
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
                    onPressed: () {},
                    child: Text(
                      'Quản lý người dùng',
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

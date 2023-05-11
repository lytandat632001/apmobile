import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:touch_app/utils/constants.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
        margin: EdgeInsets.all(20),
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            Text(
              'Tên tài khoản',
              style: TextStyle(color: kColor, fontSize: 25),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                decoration: BoxDecoration(
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
          ],
        ),
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:touch_app/utils/constants.dart';
import 'package:touch_app/utils/icons.dart';
import 'package:touch_app/view/Login_SignUp/inputWidget.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({
    Key? key,
  }) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final idProduct = TextEditingController();
    final title = TextEditingController();
    final description = TextEditingController();
    final image = TextEditingController();
    final price = TextEditingController();
    final priceBase = TextEditingController();
    final idCategory = TextEditingController();
    final review = TextEditingController();
    final star = TextEditingController();

    Future<void> postProduct() async {
      var url = 'https://api-datly.phamthanhnam.com/api/products/';

      var requestBody = {
        'title': title.text,
        'description': description.text,
        'image': image.text,
        'price': price.text,
        'priceBase': priceBase.text,
        'idCategory': idCategory.text,
        'review': review.text,
        'star': star.text,
      };

      try {
        var response = await http.post(Uri.parse(url), body: requestBody);

        if (response.statusCode == 201) {
          // Yêu cầu POST thành công
          // Xử lý dữ liệu hoặc hiển thị thông báo thành công
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Thêm sản phẩm thành công')),
          );
        } else {
          // Xử lý lỗi nếu yêu cầu không thành công
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Không thể thêm sản phẩm')));
        }
      } catch (error) {
        // Xử lý lỗi nếu có lỗi trong quá trình gửi yêu cầu
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Đã xảy ra lỗi $error')));
      }
    }

    return Scaffold(
      body: Container(
        height: size.height,
        color: kBackgroundColor,
        child: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50, bottom: 20),
                  child: Text(
                    'THÊM SẢN PHẨM',
                    style: TextStyle(
                        color: kColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                ImputWidget(
                    hint: "title",
                    hintIcon: closeIcon,
                    obscureText: false,
                    controller: title),
                ImputWidget(
                    hint: "description",
                    hintIcon: closeIcon,
                    obscureText: false,
                    controller: description),
                ImputWidget(
                    hint: "image",
                    hintIcon: closeIcon,
                    obscureText: false,
                    controller: image),
                ImputWidget(
                    hint: "price",
                    hintIcon: closeIcon,
                    obscureText: false,
                    controller: price),
                ImputWidget(
                    hint: "priceBase",
                    hintIcon: closeIcon,
                    obscureText: false,
                    controller: priceBase),
                ImputWidget(
                    hint: "idCategory",
                    hintIcon: closeIcon,
                    obscureText: false,
                    controller: idCategory),
                ImputWidget(
                    hint: "review",
                    hintIcon: closeIcon,
                    obscureText: false,
                    controller: review),
                ImputWidget(
                    hint: "star",
                    hintIcon: closeIcon,
                    obscureText: false,
                    controller: star),
                Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(inputFieldColor),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 40),
                      shape: const StadiumBorder(),
                      elevation: 10,
                      shadowColor: const Color(inputFieldColor),
                    ),
                    onPressed: () {
                      postProduct();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => super.widget));
                    },
                    // onPressed: () => widget.state ==true ? logUserIn(context,widget.emailController,widget.passwordController):signUserUp(context,widget.emailController,widget.passwordController),
                    child: const Text(
                      "Thêm sản phẩm",
                      style: TextStyle(
                        color: kColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(inputFieldColor),
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 80),
                    shape: const StadiumBorder(),
                    elevation: 10,
                    shadowColor: const Color(inputFieldColor),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  // onPressed: () => widget.state ==true ? logUserIn(context,widget.emailController,widget.passwordController):signUserUp(context,widget.emailController,widget.passwordController),
                  child: const Text(
                    "Quay lại",
                    style: TextStyle(
                      color: kColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:touch_app/utils/constants.dart';
import 'package:touch_app/utils/icons.dart';
import 'package:touch_app/view/Login_SignUp/inputWidget.dart';

class EditProductPage extends StatefulWidget {
  const EditProductPage({
    Key? key,
    required this.data,
  }) : super(key: key);
  final dynamic data;
  @override
  State<EditProductPage> createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final title = TextEditingController();
    final description = TextEditingController();
    final image = TextEditingController();
    final price = TextEditingController();
    final priceBase = TextEditingController();
    final idCategory = TextEditingController();
    final review = TextEditingController();
    final star = TextEditingController();
    title.text = widget.data['title'];
    description.text = widget.data['description'];
    image.text = widget.data['image'];
    price.text = widget.data['price'];
    priceBase.text = widget.data['priceBase'];
    idCategory.text = widget.data['idCategory'].toString();
    review.text = widget.data['review'];
    star.text = widget.data['star'];
    String idProduct = widget.data['idProduct'].toString().trim();
    Future<void> updateProduct() async {
      try {
        final url = Uri.parse(
            'https://api-datly.phamthanhnam.com/api/products/$idProduct');
        final newData = {
          'title': title.text.toString().trim(),
          'description': description.text.toString().trim(),
          'image': image.text.toString().trim(),
          'price': price.text.toString().trim(),
          'priceBase': priceBase.text.toString().trim(),
          'idCategory': idCategory.text.toString().trim(),
          'review': review.text.toString().trim(),
          'star': star.text.toString().trim(),
        };

        final headers = <String, String>{
          'Content-Type': 'application/json', // Chỉ định kiểu nội dung là JSON
        };

        final response = await http.put(
          url,
          headers: headers, // Thêm headers vào request
          body: jsonEncode(newData),
        );

        if (response.statusCode == 200) {
          // Cập nhật thành công
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cập nhật thành công')),
          );
        } else {
          // Xử lý lỗi
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cập nhật thất bại')),
          );
        }
      } catch (e) {
        print(e);
      }
    }

    Future<http.Response> deleteProduct() async {
      final http.Response response = await http.delete(
        Uri.parse('https://api-datly.phamthanhnam.com/api/products/$idProduct'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print('${idProduct}');
      return response;
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
                    hint: widget.data != null ? widget.data['title'] : "title",
                    hintIcon: closeIcon,
                    obscureText: false,
                    controller: title),
                ImputWidget(
                    hint: widget.data != null
                        ? widget.data['description']
                        : "description",
                    hintIcon: closeIcon,
                    obscureText: false,
                    controller: description),
                ImputWidget(
                    hint: widget.data != null ? widget.data['image'] : "image",
                    hintIcon: closeIcon,
                    obscureText: false,
                    controller: image),
                ImputWidget(
                    hint: widget.data != null ? widget.data['price'] : "price",
                    hintIcon: closeIcon,
                    obscureText: false,
                    controller: price),
                ImputWidget(
                    hint: widget.data != null
                        ? widget.data['priceBase']
                        : "priceBase",
                    hintIcon: closeIcon,
                    obscureText: false,
                    controller: priceBase),
                ImputWidget(
                    hint: widget.data != null
                        ? widget.data['idCategory'].toString()
                        : "idCategory",
                    hintIcon: closeIcon,
                    obscureText: false,
                    controller: idCategory),
                ImputWidget(
                    hint:
                        widget.data != null ? widget.data['review'] : "review",
                    hintIcon: closeIcon,
                    obscureText: false,
                    controller: review),
                ImputWidget( 
                  
                    hint: widget.data != null ? widget.data['star'] : "star",
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
                      updateProduct();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => super.widget));
                    },
                    // onPressed: () => widget.state ==true ? logUserIn(context,widget.emailController,widget.passwordController):signUserUp(context,widget.emailController,widget.passwordController),
                    child: const Text(
                      "Cập nhật sản phẩm",
                      style: TextStyle(
                        color: kColor,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
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
                      deleteProduct();
                      Navigator.pop(context);
                    },
                    // onPressed: () => widget.state ==true ? logUserIn(context,widget.emailController,widget.passwordController):signUserUp(context,widget.emailController,widget.passwordController),
                    child: const Text(
                      "Xóa sản phẩm",
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

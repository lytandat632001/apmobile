// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

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
  File? imageFile;
  String? imageBase64;
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

    final picker = ImagePicker();
    String? base64Image;

    // Future<void> pickImage() async {
    //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    //   if (pickedFile != null) {
    //     final bytes = await pickedFile.readAsBytes();
    //     setState(() {
    //       base64Image = base64Encode(bytes);
    //     });
    //   }
    //   print(base64Image);
    // }

    Future<void> postProduct() async {
      final url = Uri.parse('https://api-datly.phamthanhnam.com/api/products/');

      var sen_str = jsonEncode({
        'title': title.text,
        'description': description.text,
        'price': price.text,
        'priceBase': priceBase.text,
        'idCategory': int.parse(idCategory.text),
        'review': review.text,
        'star': star.text,
        'image': 'assets/images/DRESS.jpg',
      });
      try {
        final headers = <String, String>{
          'Content-Type': 'application/json', // Chỉ định kiểu nội dung là JSON
        };

        final response = await http.post(url,
            headers: headers, // Thêm headers vào request
            body: sen_str);

        if (response.statusCode == 201) {
          // Yêu cầu POST thành công
          // Xử lý dữ liệu hoặc hiển thị thông báo thành công
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Thêm sản phẩm thành công')),
          );
        } else {
          // Xử lý lỗi nếu yêu cầu không thành công
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(
                  'Không thể thêm sản phẩm' + response.statusCode.toString())));
        }
      } catch (error) {
        // Xử lý lỗi nếu có lỗi trong quá trình gửi yêu cầu
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Đã xảy ra lỗi $error')));
      }
    }

    _getFromGallery() async {
      PickedFile? pickedFile = await ImagePicker().getImage(
        source: ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
      );
      if (pickedFile != null) {
        setState(() {
          imageFile = File(pickedFile.path);
          imageBase64 = null; // Reset base64 when selecting a new image
        });
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
                    _getFromGallery();
                  },
                  child: const Text(
                    "Thêm ảnh",
                    style: TextStyle(
                      color: kColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
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
                      setState(() {
                        postProduct();
                      });
                    },
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
                  child: const Text(
                    "Quay lại",
                    style: TextStyle(
                      color: kColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

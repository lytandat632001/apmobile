// ignore_for_file: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:touch_app/data/dataProduct.dart';
import 'package:http/http.dart' as http;
import 'package:touch_app/utils/constants.dart';
import 'package:touch_app/view/Login_SignUp/logincontent.dart';
import 'package:touch_app/view/details.dart/details.dart';
import 'package:touch_app/view/manage/editProductPage.dart';

class ListEditProduct extends StatefulWidget {
  const ListEditProduct({super.key});

  @override
  State<ListEditProduct> createState() => _ListEditProductState();
}

class _ListEditProductState extends State<ListEditProduct> {
  List<dynamic> products = [];

  Future<void> fetchProducts() async {
    var apiUrl = 'https://api-datly.phamthanhnam.com/api/products/';

    try {
      var response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        setState(() {
          products = jsonDecode(response.body);
        });
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
    fetchProducts();
  }

  @override
  void didChangeDependencies() {
    fetchProducts();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // itemsOnExplore = widget.data;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBackgroundColor,
        elevation: 0.5,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: kColor,
            )),
        title: Text(
          'DANH SÁCH SẢN PHẨM',
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: kColor),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginContentNew(),
                    ));
              },
              icon: Icon(
                Icons.close,
                color: kColor,
              ))
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: size.width,
              height: size.height,
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: products.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.67, crossAxisCount: 2),
                itemBuilder: (context, index) {
                  dynamic current = products[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                EditProductPage(data: current)),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          width: size.width * 0.5,
                          height: size.height * 0.2,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(current['image']),
                            ),
                          ),
                        ),
                        Text(
                          current['title'],
                          style: const TextStyle(
                            color: kColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          '\$${current['price']}',
                          style: const TextStyle(
                            color: kColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          '\$${current['priceBase']}',
                          style: const TextStyle(
                            color: kColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        RatingBarIndicator(
                          rating: 4.6,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.black87,
                          ),
                          itemCount: 5,
                          itemSize: 23.0,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

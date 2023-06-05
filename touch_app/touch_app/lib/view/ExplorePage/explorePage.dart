// ignore_for_file: file_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:touch_app/data/dataProduct.dart';
import 'package:http/http.dart' as http;
import 'package:touch_app/utils/constants.dart';
import 'package:touch_app/view/details.dart/details.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  List<dynamic> products = [];
  List<dynamic> men = [];
  List<dynamic> women = [];
  List<dynamic> children = [];
  List<dynamic> accessories = [];
  List<dynamic> filteredProducts = [];
  bool showAll = true;
  bool showMen = false;
  bool showWomen = false;
  bool showChildren = false;
  bool showAccessories = false;

  Future<void> fetchProducts() async {
    var apiUrl = 'https://api-datly.phamthanhnam.com/api/products/';

    try {
      var response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        setState(() {
          products = jsonDecode(response.body);
        });

        men = products.where((product) => product['idCategory'] == 1).toList();
        women =
            products.where((product) => product['idCategory'] == 2).toList();
        children =
            products.where((product) => product['idCategory'] == 3).toList();
        accessories =
            products.where((product) => product['idCategory'] == 4).toList();
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

  List<dynamic> _getProductList() {
    if (showAll) {
      return products;
    } else if (showMen) {
      return men =
          products.where((product) => product['idCategory'] == 1).toList();
    } else if (showWomen) {
      return women =
          products.where((product) => product['idCategory'] == 2).toList();
    } else if (showChildren) {
      return children =
          products.where((product) => product['idCategory'] == 3).toList();
    } else if (showAccessories) {
      return accessories =
          products.where((product) => product['idCategory'] == 4).toList();
    } else {
      return filteredProducts;
    }
  }

  void searchProducts(String query) {
    setState(() {
      if (query.isEmpty) {
        // Nếu giá trị tìm kiếm rỗng, hiển thị tất cả sản phẩm
        showAll = true;
        showMen = false;
        showWomen = false;
        showChildren = false;
        showAccessories = false;
      } else if (query.isNotEmpty) {
        // Lọc danh sách sản phẩm dựa trên giá trị tìm kiếm
        showAll = false;
        showMen = false;
        showWomen = false;
        showChildren = false;
        showAccessories = false;

        filteredProducts = products.where((product) {
          String title = product['title'].toString().toLowerCase();
          return title.contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String hintText = 'Tìm kiếm sản phẩm';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: TextField(
                decoration: InputDecoration(
                  hintText: hintText,
                  prefixIcon: Icon(
                    Icons.search,
                    color: kColor,
                    size: 30,
                  ),
                ),
                onChanged: (value) {
                  // Gọi hàm tìm kiếm ở đây
                  setState(() {
                    hintText = value.isEmpty
                        ? 'Tìm kiếm sản phẩm'
                        : 'Đang tìm kiếm: $value';
                    searchProducts(value);
                  });
                },
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(kBackgroundColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              0), // Giá trị bo góc của border
                          side: BorderSide(
                              color:
                                  Colors.black), // Màu sắc và độ dày của border
                        ),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        showAll = true;
                        showMen = false;
                        showWomen = false;
                        showChildren = false;
                        showAccessories = false;
                      });
                    },
                    child: Text(
                      'Tất cả',
                      style: TextStyle(color: kColor),
                    ),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(kBackgroundColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              0), // Giá trị bo góc của border
                          side: BorderSide(
                              color:
                                  Colors.black), // Màu sắc và độ dày của border
                        ),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        showAll = false;
                        showMen = true;
                        showWomen = false;
                        showChildren = false;
                        showAccessories = false;
                      });
                    },
                    child: Text('Nam', style: TextStyle(color: kColor)),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(kBackgroundColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              0), // Giá trị bo góc của border
                          side: BorderSide(
                              color:
                                  Colors.black), // Màu sắc và độ dày của border
                        ),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        showAll = false;
                        showMen = false;
                        showWomen = true;
                        showChildren = false;
                        showAccessories = false;
                      });
                    },
                    child: Text('Nữ', style: TextStyle(color: kColor)),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(kBackgroundColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              0), // Giá trị bo góc của border
                          side: BorderSide(
                              color:
                                  Colors.black), // Màu sắc và độ dày của border
                        ),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        showAll = false;
                        showMen = false;
                        showWomen = false;
                        showChildren = true;
                        showAccessories = false;
                      });
                    },
                    child: Text('Trẻ em', style: TextStyle(color: kColor)),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(kBackgroundColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              0), // Giá trị bo góc của border
                          side: BorderSide(
                              color:
                                  Colors.black), // Màu sắc và độ dày của border
                        ),
                      ),
                    ),
                    onPressed: () {
                      setState(() {
                        showAll = false;
                        showMen = false;
                        showWomen = false;
                        showChildren = false;
                        showAccessories = true;
                      });
                    },
                    child: Text('Phụ kiện', style: TextStyle(color: kColor)),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                ],
              ),
            ),
            SizedBox(
              width: size.width,
              height: size.height * 0.7,
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _getProductList().length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.67, crossAxisCount: 2),
                itemBuilder: (context, index) {
                  dynamic current = _getProductList()[index];

                  String formattedPrice =
                      current['price'].split('.')[0]; // Lấy phần nguyên
                  // Thêm dấu chấm ngăn cách hàng nghìn
                  final pattern = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
                  formattedPrice = formattedPrice.replaceAllMapped(
                      pattern, (match) => '${match.group(1)}.');

                  String formattedPriceBase =
                      current['priceBase'].split('.')[0]; // Lấy phần nguyên
                  // Thêm dấu chấm ngăn cách hàng nghìn
                  final patternBase = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
                  formattedPriceBase = formattedPriceBase.replaceAllMapped(
                      patternBase, (match) => '${match.group(1)}.');

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Details(
                                  data: current,
                                )),
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
                          '₫ $formattedPrice',
                          style: const TextStyle(
                            color: kColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          '₫ $formattedPriceBase',
                          style: const TextStyle(
                            color: kColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        RatingBarIndicator(
                          rating: double.parse(current['star']),
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

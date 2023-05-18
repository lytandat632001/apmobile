// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: file_names, unused_local_variable, no_leading_underscores_for_local_identifiers, unused_element, avoid_print, camel_case_types

import 'dart:convert';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:touch_app/utils/constants.dart';
import 'package:touch_app/utils/userProvider.dart';
import 'package:touch_app/view/ExplorePage/explorePage.dart';
import 'package:touch_app/view/details.dart/details.dart';

import 'buildCard.dart';

class HomePageContent extends StatefulWidget {
  const HomePageContent({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  List<dynamic> products = [];
  List<dynamic> men = [];
  List<dynamic> women = [];
  List<dynamic> children = [];
  List<dynamic> accessories = [];

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

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userId = userProvider.userId;
    final token = userProvider.token;
    final size = MediaQuery.of(context).size;
    late PageController _controllerMen =
        PageController(initialPage: 2, viewportFraction: 0.7);
    late PageController _controllerWomen =
        PageController(initialPage: 2, viewportFraction: 0.7);
    late PageController _controllerChildren =
        PageController(initialPage: 2, viewportFraction: 0.7);
    late PageController _controllerAccessories =
        PageController(initialPage: 2, viewportFraction: 0.7);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Clothing

              FadeInUp(
                delay: const Duration(milliseconds: 300),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Men',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: kColor),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ExplorePage(),
                                  ));
                            },
                            child: const Text(
                              "See all",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: kColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: size.width,
                      height: size.height * 0.5,
                      color: kBackgroundColor,
                      child: PageView.builder(
                        controller: _controllerMen,
                        physics: const BouncingScrollPhysics(),
                        itemCount: men.length,
                        itemBuilder: (context, index) {
                          var data = men[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Details(
                                          data: data,
                                        )),
                              );
                            },
                            child: view(index, size, _controllerMen, data),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              ////Accessories
              FadeInUp(
                delay: const Duration(milliseconds: 300),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Women',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: kColor),
                          ),
                          GestureDetector(
                            onTap: () {
                              print('See all');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ExplorePage(
                                        // data: widget.products,
                                        ),
                                  ));
                            },
                            child: const Text(
                              "See all",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: kColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: size.width,
                      height: size.height * 0.5,
                      color: kBackgroundColor,
                      child: PageView.builder(
                        controller: _controllerWomen,
                        physics: const BouncingScrollPhysics(),
                        itemCount: women.length,
                        itemBuilder: (context, index) {
                          var data = women[index];
                          print(data['title']);
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Details(
                                          data: data,
                                        )),
                              );
                            },
                            child: view(index, size, _controllerWomen, data),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              /// Shoes
              FadeInUp(
                delay: const Duration(milliseconds: 300),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Children",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: kColor),
                          ),
                          GestureDetector(
                            onTap: () {
                              print('See all');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ExplorePage(
                                        // data: widget.products,
                                        ),
                                  ));
                            },
                            child: const Text(
                              "See all",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: kColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: size.width,
                      height: size.height * 0.5,
                      color: kBackgroundColor,
                      child: PageView.builder(
                        controller: _controllerChildren,
                        physics: const BouncingScrollPhysics(),
                        itemCount: children.length,
                        itemBuilder: (context, index) {
                          dynamic data = children[index];
                          return GestureDetector(
                              onTap: () {
                                print(data['title']);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Details(
                                            data: data,
                                          )),
                                );
                              },
                              child:
                                  view(index, size, _controllerChildren, data));
                        },
                      ),
                    ),
                  ],
                ),
              ),

              //Accessories
              FadeInUp(
                delay: const Duration(milliseconds: 300),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Accessories",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: kColor),
                          ),
                          GestureDetector(
                            onTap: () {
                              print('See all');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ExplorePage(
                                        // data: widget.products,
                                        ),
                                  ));
                            },
                            child: const Text(
                              "See all",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: kColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: size.width,
                      height: size.height * 0.5,
                      color: kBackgroundColor,
                      child: PageView.builder(
                        controller: _controllerAccessories,
                        physics: const BouncingScrollPhysics(),
                        itemCount: accessories.length,
                        itemBuilder: (context, index) {
                          dynamic data = accessories[index];
                          return GestureDetector(
                              onTap: () {
                                print(data['title']);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Details(
                                            data: data,
                                          )),
                                );
                              },
                              child: view(
                                  index, size, _controllerAccessories, data));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget view(int index, Size size, PageController _controller, dynamic data) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          double value = 0.0;
          if (_controller.position.haveDimensions) {
            value = index.toDouble() - (_controller.page ?? 0);
            value = (value * 0.04).clamp(-1, 1);
          }
          return Transform.rotate(
            angle: 3.14 * value,
            child: buildCard(
              size: size,
              data: data,
            ),
          );
        });
  }
}

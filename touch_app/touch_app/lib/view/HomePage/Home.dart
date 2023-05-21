// ignore_for_file: file_names, prefer_final_fields



import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:http/http.dart'as http;
import 'package:touch_app/utils/constants.dart';
import 'package:touch_app/view/CartPage/cart.dart';
import 'package:touch_app/view/ExplorePage/explorePage.dart';
import 'package:touch_app/view/HomePage/searchCustom.dart';
import 'package:touch_app/view/LikePage/likePage.dart';
import 'package:touch_app/view/account/account.dart';

import 'homePageContent.dart';

class HomeProduct extends StatefulWidget {
  const HomeProduct({super.key});

  @override
  State<HomeProduct> createState() => _HomeProductState();
}

class _HomeProductState extends State<HomeProduct> {
 List<dynamic> products = [];
  Future<void> fetchProducts() async {
    var apiUrl = 'https://api-datly.phamthanhnam.com/api/products/';

    try {
      var response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        setState(() {
          products = jsonDecode(response.body);
        });
        print(products);
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

  int _index = 0;
   List<Widget> _widgetScreen = [
    HomePageContent(),
    ExplorePage(),
    const LikePage(),
    const CartPage(),
  ];

  List<String> a = ['ĐỢT PHÁT HÀNH', 'CỬA HÀNG', 'YÊU THÍCH', 'GIỎ HÀNG'];
  String b = 'ĐỢT PHÁT HÀNH';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0.5,
        title: Text(
          b,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: kColor),
        ),
        actions: [
          IconButton(
            onPressed: () {
              showSearch(context: context, delegate: SearchCustom(products));
            },
            icon: const Icon(FontAwesomeIcons.magnifyingGlass),
            iconSize: 20,
            color: kColor,
          ),
          IconButton(
            onPressed: () {
              // signOut();
            },
            icon: const Icon(FontAwesomeIcons.bell),
            iconSize: 20,
            color: kColor,
            
          ),
          IconButton(
            onPressed: () {
              
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AccountPage(),
                ),
              );
            },
            icon: const Icon(FontAwesomeIcons.user),
            iconSize: 20,
            color: kColor,
          ),
        ],
        backgroundColor: kBackgroundColor,
      ),
      body: _widgetScreen.elementAt(_index),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: GNav(
            padding: const EdgeInsets.all(18.0),
            backgroundColor: kPrimaryColor,
            color: kBackgroundColor,
            activeColor: kBackgroundColor,
            gap: 8,
            tabBackgroundColor: Colors.grey.shade800,
            tabBorderRadius: 25,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            selectedIndex: _index,
            onTabChange: (value) {
              setState(() {
                _index = value;
                b = a[_index];
              });
            },
            tabs: const [
              GButton(
                icon: Icons.home,
                text: "Home",
              ),
              GButton(
                icon: Icons.manage_search,
                text: "Explore",
              ),
              GButton(
                icon: Icons.favorite_border_outlined,
                text: "Likes",
              ),
              GButton(
                icon: Icons.shopping_bag_outlined,
                text: "Cart",
              ),
            ],
          ),
        ),
      ),
    );
  }
}

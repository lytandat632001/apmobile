import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import 'package:touch_app/data/dataProduct.dart';
import 'package:touch_app/utils/constants.dart';
import 'package:touch_app/utils/userProvider.dart';
import 'package:touch_app/view/details.dart/IconFavorite.dart';

class Details extends StatefulWidget {
  const Details({super.key, required this.data});
  final dynamic data;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  List<dynamic> likes = [];
  List<dynamic> likeIdUser = [];
  List<dynamic> filterCarts = [];
  bool islike = false;
  List<dynamic> carts = [];
  List<dynamic> cartIdUser = [];
  bool isCart = false;
  bool isFetching = true;
  int idLike = 0;

  Future<void> fetchLike() async {
    var apiUrl = 'https://api-datly.phamthanhnam.com/api/like/';
    try {
      var response = await http.get(Uri.parse(apiUrl));
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final userId = userProvider.userId;
      final token = userProvider.token;

      if (response.statusCode == 200) {
        setState(() {
          likes = jsonDecode(response.body);
          likeIdUser = likes;
        });
        setState(() {
          likeIdUser = likes
              .where((like) =>
                  like['idUser'] == userId &&
                  like['idProduct'] == widget.data['idProduct'])
              .toList();

          if (likeIdUser.isNotEmpty) {
            islike = true;
            idLike = likeIdUser[0]['id'];
          } else {
            islike = false;
            idLike = 0;
          }

          isFetching = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(' Đã lấy danh sách sản phẩm')),
        );
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

  Future<void> fetchCarts() async {
    var apiUrl = 'https://api-datly.phamthanhnam.com/api/carts/';
    try {
      var response = await http.get(Uri.parse(apiUrl));
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final userId = userProvider.userId;
      final token = userProvider.token;

      if (response.statusCode == 200) {
        setState(() {
          carts = jsonDecode(response.body);
          // cartIdUser = likes;
        });
        setState(() {
          cartIdUser = carts
              .where((carts) =>
                  carts['idUser'] == userId &&
                  carts['idProduct'] == widget.data['idProduct'] &&
                  carts['code'] == 1)
              .toList();

          if (cartIdUser.isNotEmpty) {
            isCart = true;
          } else {
            isCart = false;
          }

          isFetching = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(' Đã lấy danh sách sản phẩm')),
        );
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

  Future<http.Response> updateCarts(int value) {
    int idCart = cartIdUser[0]['idCart'];
    return http.put(
      Uri.parse('https://api-datly.phamthanhnam.com/api/carts/$idCart'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'quantity': cartIdUser[0]['quantity'] + value,
        'idUser': cartIdUser[0]['idUser'],
        'idProduct': cartIdUser[0]['idProduct'],
        'code': cartIdUser[0]['code'],
        'size': cartIdUser[0]['size']
      }),
    );
  }

  Future<void> postCart(
      int? userId, int idProduct, int quantity, String size) async {
    final response = await http.post(
      Uri.parse('https://api-datly.phamthanhnam.com/api/carts/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'quantity': quantity,
        'idUser': userId,
        'idProduct': idProduct,
        'code': 1,
        'size': size
      }),
    );

    if (response.statusCode == 201) {
      print('thanh cong them vao gio hang');
    } else {
      throw Exception('them vao gio hang that bai');
    }
  }

  int value = 1;
  void decreasePrice() {
    setState(() {
      value -= 1;
    });
  }

  void increasePrice() {
    setState(() {
      value += 1;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchLike();
    fetchCarts();
  }

  int selectedSize = 3;
  @override
  Widget build(BuildContext context) {
    if (isFetching) {
      return const Center(
        child: CircularProgressIndicator(), // Hoặc tiến trình chờ khác
      );
    }
    dynamic current = widget.data;
    // bool contains = itemsOnCart.contains(current);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userId = userProvider.userId;
    final token = userProvider.token;

    String formattedPrice = current['price'].split('.')[0]; // Lấy phần nguyên
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

    final size = MediaQuery.of(context).size;
    List<String> sizes = ['S', 'M', 'L', 'XL', 'XXL'];
    // var selectedSize = sizes[2];
    return Scaffold(
      backgroundColor: kBackgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () async {
            // Navigator.pop(context);
            Navigator.of(context, rootNavigator: true).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width,
                height: size.height * 0.5,
                child: Stack(children: [
                  Hero(
                    tag: current['image'],
                    child: Container(
                      width: size.width,
                      height: size.height * 0.5,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(current['image']),
                            fit: BoxFit.cover),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                current['title'],
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: kColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              FavoriteIcon(
                                islike,
                                idUser: userId,
                                idProduct: current['idProduct'],
                                idLike: idLike,
                                size: sizes[selectedSize],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Text('₫$formattedPrice',
                                style: const TextStyle(
                                    fontSize: 20, color: kColor)),
                            const SizedBox(width: 40),
                            Text(current['nameCategory'],
                                style: const TextStyle(
                                    fontSize: 18, color: kColor)),
                            const SizedBox(width: 40),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 20),
                          child: Row(
                            children: [
                              Text('₫$formattedPriceBase',
                                  style: const TextStyle(
                                      fontSize: 20, color: kColor)),
                              const SizedBox(width: 40),
                              SizedBox(
                                width: size.width * 0.2,
                                height: size.height * 0.04,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          if (value > 1) {
                                            decreasePrice();
                                          } else {
                                            value = 1;
                                          }
                                        });
                                      },
                                      child: const Icon(
                                        Icons.remove_circle_outline,
                                        color: kColor,
                                        size: 25,
                                      ),
                                    ),
                                    Text(
                                      value.toString(),
                                      style: const TextStyle(
                                          color: kColor,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 18),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          increasePrice();
                                        });
                                      },
                                      child: const Icon(
                                        Icons.add_circle_outline_outlined,
                                        color: kColor,
                                        size: 25,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        FadeInUp(
                          delay: const Duration(milliseconds: 500),
                          child: SizedBox(
                            // color: Colors.red,
                            width: size.width * 0.9,
                            height: size.height * 0.08,
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: sizes.length,
                                itemBuilder: (ctx, index) {
                                  var current = sizes[index];
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedSize = index;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 15, bottom: 8, top: 8),
                                      child: AnimatedContainer(
                                        width: size.width * 0.12,
                                        decoration: BoxDecoration(
                                          color: selectedSize == index
                                              ? kLinkColor
                                              : kBackgroundColor,
                                          border: Border.all(
                                              color: kColor, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        duration:
                                            const Duration(milliseconds: 200),
                                        child: Center(
                                          child: Text(
                                            current,
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500,
                                                color: selectedSize == current
                                                    ? Colors.white
                                                    : Colors.black),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                    side: BorderSide(color: Colors.black)),
                              ),
                              //  elevation: MaterialStateProperty.all(0),
                            ),
                            onPressed: () {
                              String messageText;
                              setState(() {
                                print(sizes[selectedSize]);
                                print(isCart);
                                if (isCart == true) {
                                  updateCarts(value);
                                  messageText =
                                      "Sản phẩm đã tồn tại trong giỏ hàng!";
                                } else {
                                  postCart(userId, current['idProduct'], value,
                                      sizes[selectedSize]);
                                  messageText =
                                      "Sản phẩm đã được thêm vào giỏ hàng!";
                                }

                                var snackBar = SnackBar(
                                    backgroundColor: Colors.transparent,
                                    duration: const Duration(seconds: 3),
                                    content: AwesomeSnackbarContent(
                                        title: current['title'],
                                        message: messageText,
                                        contentType: ContentType.success));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              });
                            },
                            child: SizedBox(
                              height: 40,
                              width: size.width * 0.7,
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'THÊM VÀO GIỎ',
                                    style: TextStyle(
                                        color: kColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                    Icons.shopping_bag_outlined,
                                    color: kColor,
                                    size: 25,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'MIÊU TẢ SẢN PHẨM',
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: size.width * 0.8,
                                  child: Text('${current['description']}',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          color: kColor,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('XẾP HẠNG & ĐÁNH GIÁ',
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold)),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: Row(
                                  children: [
                                    Text(current['star'],
                                        style: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(
                                      width: 100,
                                    ),
                                    Text(current['review'],
                                        style: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              RatingBarIndicator(
                                rating: double.parse(current['star']),
                                itemBuilder: (context, index) => const Icon(
                                  Icons.star,
                                  color: Colors.black87,
                                ),
                                itemCount: 5,
                                itemSize: 30,
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

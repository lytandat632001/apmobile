import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touch_app/data/dataProduct.dart';
import 'package:touch_app/utils/constants.dart';
import 'package:touch_app/utils/userProvider.dart';
import 'package:touch_app/view/CartPage/checkout.dart';
import 'package:touch_app/view/HomePage/Home.dart';
import 'package:http/http.dart' as http;

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<dynamic> cartIdUser = [];
  List<dynamic> products = [];
  List<dynamic> cart = [];
  List<dynamic> filteredList = [];
  bool isFetching = true;
  int value = 1;

  Future<void> fetchCarts() async {
    var apiUrlProduct = 'https://api-datly.phamthanhnam.com/api/products/';
    var apiUrlCart = 'https://api-datly.phamthanhnam.com/api/carts/';
    try {
      var response1 = await http.get(Uri.parse(apiUrlProduct));
      var response2 = await http.get(Uri.parse(apiUrlCart));
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final userId = userProvider.userId;
      final token = userProvider.token;

      if (response1.statusCode == 200 && response2.statusCode == 200) {
        setState(() {
          products = jsonDecode(response1.body);
          cart = jsonDecode(response2.body);
          cartIdUser = cart
              .where((cart) => cart['idUser'] == userId && cart['code'] == 1)
              .toList();

          filteredList = products
              .where((itemB) => cartIdUser.any((itemA) =>
                  itemA['idProduct'] == itemB['idProduct'] &&
                  itemA['code'] == 1))
              .toList();

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

  Future<http.Response> deleteCart(int idCart) async {
    final http.Response response = await http.delete(
      Uri.parse('https://api-datly.phamthanhnam.com/api/carts/$idCart'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print('xoa ra khoi gio hang');
    return response;
  }

  @override
  void initState() {
    super.initState();
    fetchCarts();
  }

  Future<http.Response> updateCart(
    int idUser,
    int idProduct,
    int quantity,
    int idCart,
  ) {
    return http.put(
      Uri.parse('https://api-datly.phamthanhnam.com/api/products/$idCart'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, int>{
        'idUser': idUser,
        'idProduct': idProduct,
        'quantity': quantity,
        'code': 1,
      }),
    );
  }

  void decreasePrice(int index, int? idUser) {
    setState(() {
      if (cartIdUser[index]['quantity'] > 1) {
        cartIdUser[index]['quantity'] -= 1;
        updateCart(idUser!, cartIdUser[index]['idProduct'],
            cartIdUser[index]['quantity'], cartIdUser[index]['idCart']);
      } else {
        onDelete(filteredList[index]);
      }
    });
  }

  void increasePrice(int index, int? idUser) {
    setState(() {
      cartIdUser[index]['quantity'] += 1;
      updateCart(idUser!, cartIdUser[index]['idProduct'],
          cartIdUser[index]['quantity'], cartIdUser[index]['idCart']);
    });
  }

  double calculateTotalPrice() {
    double total = 0.0;
    if (filteredList.isEmpty) {
      total = 0;
    } else {
      for (int i = 0; i < filteredList.length; i++) {
        dynamic data = filteredList[i];
        if (data['priceBase'] is String) {
          double datas = double.parse(data['priceBase']);
          total += datas * cartIdUser[i]['quantity'];
        }
      }
    }
    return total;
  }

  double calculateShipping() {
    double shipping = 0.0;
    if (calculateTotalPrice() > 2000000) {
      shipping = 0.0;
      return shipping;
    } else {
      shipping = 30000;
      return shipping;
    }
  }

  void onDelete(dynamic data) {
    setState(() {
      if (filteredList.length == 1) {
        filteredList.clear();
      } else {
        List<dynamic> filterDelete = [];
        filterDelete = cartIdUser
            .where((like) => like['idProduct'] == data['idProduct'])
            .toList();
        int idCart = filterDelete[0]['idCart'];
        deleteCart(idCart);
        print(idCart);
        print('idcart');
        filteredList.removeWhere(
            (element) => element['idProduct'] == data['idProduct']);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> sizes = ['S', 'M', 'L', 'XL', 'XXL'];
    final size = MediaQuery.of(context).size;

    if (isFetching) {
      return const Center(
        child: CircularProgressIndicator(), // Hoặc tiến trình chờ khác
      );
    }
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userId = userProvider.userId;
    final token = userProvider.token;
    String formattedTotal = (calculateTotalPrice() + calculateShipping())
        .toString()
        .split('.')[0]; // Lấy phần nguyên
    // Thêm dấu chấm ngăn cách hàng nghìn
    final patternTotal = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    formattedTotal = formattedTotal.replaceAllMapped(
        patternTotal, (match) => '${match.group(1)}.');

    String formattedShipping =
        calculateShipping().toString().split('.')[0]; // Lấy phần nguyên
    // Thêm dấu chấm ngăn cách hàng nghìn
    final patternShipping = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    formattedShipping = formattedShipping.replaceAllMapped(
        patternShipping, (match) => '${match.group(1)}.');

    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
          children: [
            SizedBox(
              //color: Colors.blue,
              width: size.width,
              height: size.height * 0.6,
              child: filteredList.isNotEmpty
                  ? ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemCount: filteredList.length,
                      itemBuilder: (context, index) {
                        var current = filteredList[index];
                        int quantity = cartIdUser[index]['quantity'];
                        String formattedPrice =
                            current['price'].split('.')[0]; // Lấy phần nguyên
                        // Thêm dấu chấm ngăn cách hàng nghìn
                        final pattern = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
                        formattedPrice = formattedPrice.replaceAllMapped(
                            pattern, (match) => '${match.group(1)}.');

                        String formattedPriceBase = current['priceBase']
                            .split('.')[0]; // Lấy phần nguyên
                        // Thêm dấu chấm ngăn cách hàng nghìn
                        final patternBase =
                            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
                        formattedPriceBase =
                            formattedPriceBase.replaceAllMapped(
                                patternBase, (match) => '${match.group(1)}.');

                        return Container(
                          margin: const EdgeInsets.all(8),
                          // margin: const EdgeInsets.only(top: 8),
                          width: size.width,
                          height: size.height * 0.2,
                          color: const Color(0xfff5f5f5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.all(5),
                                width: size.width * 0.35,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(current['image']),
                                      fit: BoxFit.cover,
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        offset: Offset(0, 4),
                                        blurRadius: 4,
                                        color: Color.fromARGB(61, 0, 0, 0),
                                      ),
                                    ]),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.5,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            current['title'],
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              onDelete(current);
                                            },
                                            icon: const Icon(Icons.close),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text('₫$formattedPrice'),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text('₫$formattedPriceBase'),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text('Kích cỡ: ${sizes[2]}'),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      width: size.width * 0.2,
                                      height: size.height * 0.04,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                decreasePrice(index, userId);
                                              });
                                            },
                                            child: const Icon(
                                              Icons.remove_circle_outline,
                                              color: kColor,
                                              size: 25,
                                            ),
                                          ),
                                          Text(
                                            quantity.toString(),
                                            style: const TextStyle(
                                                color: kColor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 18),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                increasePrice(index, userId);
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
                            ],
                          ),
                        );
                      },
                    )
                  :

                  ///Empty cart
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'GIỎ HÀNG CỦA BẠN ĐANG TRỐNG',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: kColor),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Text(
                            'Hãy thể hiện cho mình một phong cách sáng tạo',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: kColor),
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
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HomeProduct(),
                                  ));
                            },
                            child: SizedBox(
                              height: 40,
                              width: size.width * 0.7,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
                                  Text(
                                    'CÙNG XEM XU HƯỚNG',
                                    style: TextStyle(
                                        color: kColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                    Icons.arrow_right_alt,
                                    color: kColor,
                                    size: 30,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 0.05),
              ),
              width: size.width,
              height: size.height * 0.2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 25, left: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Phí vận chuyển",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                        Text(
                          formattedShipping.toString(),
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30, left: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Tổng thanh toán",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                        Text(
                          formattedTotal,
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                              side: BorderSide(color: Colors.black)),
                        ),
                        //  elevation: MaterialStateProperty.all(0),
                      ),
                      onPressed: () {
                        print(cartIdUser);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CheckoutPage(
                                  shipping: calculateShipping(),
                                  total: calculateTotalPrice() +
                                      calculateShipping(),
                                  carts: cartIdUser,
                                  idUser: userId),
                            ));
                      },
                      child: SizedBox(
                        height: 40,
                        width: size.width * 0.8,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Thanh toán',
                              style: TextStyle(
                                  color: kColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            Icon(
                              Icons.arrow_right_alt,
                              color: kColor,
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:touch_app/utils/constants.dart';
import 'package:touch_app/utils/icons.dart';
import 'package:touch_app/utils/userProvider.dart';
import 'package:intl/intl.dart';
import '../Login_SignUp/inputWidget.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  dynamic user;
  bool isFetching = true;
  List<dynamic> checkoutList = [];
  List<dynamic> cartList = [];
  List<dynamic> productList = [];
  List<dynamic> cartIdUser = [];
  List<dynamic> filteredListCart1 = [];
  List<dynamic> filteredListCart2 = [];
  List<dynamic> filteredListCart3 = [];
  List<dynamic> filteredListProduct1 = [];
  List<dynamic> filteredListProduct2 = [];
  List<dynamic> filteredListProduct3 = [];

  List<dynamic> checkoutIdUserStatus2 = [];
  List<dynamic> checkoutIdUserStatus3 = [];
  List<dynamic> checkoutIdUserStatus4 = [];

  Future<void> fetchCheckouts() async {
    var apiUrl1 = 'https://api-datly.phamthanhnam.com/api/checkouts/';
    var apiUrl2 = 'https://api-datly.phamthanhnam.com/api/carts/';
    var apiUrl3 = 'https://api-datly.phamthanhnam.com/api/products/';
    try {
      var response1 = await http.get(Uri.parse(apiUrl1));
      var response2 = await http.get(Uri.parse(apiUrl2));
      var response3 = await http.get(Uri.parse(apiUrl3));
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final userId = userProvider.userId;
      final token = userProvider.token;

      if (response1.statusCode == 200 && response2.statusCode == 200) {
        setState(() {
          checkoutList = jsonDecode(response1.body);
          cartList = jsonDecode(response2.body);
          productList = jsonDecode(response3.body);

          //Loc danh sach checkout theo idUser và idStatus
          //2 là đang chuẩn bị hàng
          //3 là đang giao
          //4 là đã nhận
          checkoutIdUserStatus2 = checkoutList
              .where((element) => element['idStatus'] == 2)
              .toList();
          checkoutIdUserStatus3 = checkoutList
              .where((element) => element['idStatus'] == 3)
              .toList();
          checkoutIdUserStatus4 = checkoutList
              .where((element) => element['idStatus'] == 4)
              .toList();

          filteredListCart1 = cartList
              .where((itemB) => checkoutIdUserStatus2.any((itemA) =>
                  itemA['idCart'] == itemB['idCart'] && itemB['code'] == 2))
              .toList();
          filteredListCart2 = cartList
              .where((itemB) => checkoutIdUserStatus3.any((itemA) =>
                  itemA['idCart'] == itemB['idCart'] && itemB['code'] == 2))
              .toList();
          filteredListCart3 = cartList
              .where((itemB) => checkoutIdUserStatus4.any((itemA) =>
                  itemA['idCart'] == itemB['idCart'] && itemB['code'] == 2))
              .toList();

          print(filteredListCart1);
          print(filteredListCart2);
          print(filteredListCart3);

          //   cartIdUser = cartList.where((cart) => cart['idUser'] == userId).toList();
          // bool isFetching = false;
          filteredListProduct1 = productList
              .where((itemB) => filteredListCart1
                  .any((itemA) => itemA['idProduct'] == itemB['idProduct']))
              .toList();
          filteredListProduct2 = productList
              .where((itemB) => filteredListCart2
                  .any((itemA) => itemA['idProduct'] == itemB['idProduct']))
              .toList();
          filteredListProduct3 = productList
              .where((itemB) => filteredListCart3
                  .any((itemA) => itemA['idProduct'] == itemB['idProduct']))
              .toList();
        });
        print(filteredListProduct1);
        print(filteredListProduct2);
        print(filteredListProduct3);

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

  Future<http.Response> updateCheckout(int idCheckout, double total,
      double shipping, int idCart, String dateBuy, int idUser, int status) {
    return http.put(
      Uri.parse('https://api-datly.phamthanhnam.com/api/checkouts/$idCheckout'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "idStatus": status,
        "idUser": idUser,
        "total": total,
        "idShipping": shipping,
        "dateBuy": dateBuy,
        "type": "Thanh toán khi nhận hàng",
        "idCart": idCart
      }),
    );
  }

  @override
  void initState() {
    super.initState();
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    int? userId = userProvider.userId;

    fetchCheckouts();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: kColor,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text(
              "Tài khoản",
              style: TextStyle(color: kColor),
            ),
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            elevation: 0.5,
            bottom: TabBar(
                labelColor: kColor,
                labelStyle:
                    TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                tabs: [
                  Tab(
                    text: "Đơn hàng",
                  ),
                  Tab(
                    text: "Đang giao hàng",
                  ),
                  Tab(
                    text: "Đã giao hàng",
                  )
                ]),
          ),
          body: SizedBox(
            width: size.width,
            height: size.height,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                      width: size.width,
                      height: size.height * 0.7,
                      child: TabBarView(children: [
                        SizedBox(
                          width: size.width,
                          height: size.height * 0.6,
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: checkoutIdUserStatus2.length,
                            itemBuilder: (context, index) {
                              var checkouts = checkoutIdUserStatus2[index];
                              var carts = filteredListCart1[index];
                              var products = productList.where((itemB) {
                                // Lấy giá trị của 'idProduct' từ itemB
                                dynamic idProductB = itemB['idProduct'];

                                // Kiểm tra xem idProductB có tồn tại trong filteredListCart1[index] hay không
                                if (carts.containsValue(idProductB)) {
                                  return true; // Điều kiện thỏa mãn
                                } else {
                                  return false; // Điều kiện không thỏa mãn
                                }
                              }).toList();

                              DateTime dateTime = DateTime.parse(
                                  checkouts['dateBuy'].toString());
                              String formattedDate =
                                  DateFormat('dd/MM/yyyy').format(dateTime);
                              String formatted =
                                  DateFormat('yyyy/MM/dd').format(dateTime);
                              double total =
                                  double.parse(carts['quantity'].toString()) *
                                      double.parse(
                                          products[0]['priceBase'].toString());
                              return Container(
                                margin: EdgeInsets.only(top: 10),
                                width: size.width,
                                height: size.height * 0.2,
                                child: Row(children: [
                                  Container(
                                    margin: EdgeInsets.all(8.0),
                                    width: size.width * 0.35,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        image: DecorationImage(
                                          image: AssetImage(
                                            'assets/images/adidas-sport-pant.jpg',
                                          ),
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
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 10.0, left: 10),
                                    width: size.width * 0.5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(products[0]['title'].toString()),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                'Số lượng: ${carts['quantity']}'),
                                            Container(
                                              decoration: BoxDecoration(
                                                  border:
                                                      Border.all(width: 0.5),
                                                  color: kColor),
                                              child: TextButton(
                                                  onPressed: () {
                                                    updateCheckout(
                                                        int.parse(checkouts[
                                                                'idCheckout']
                                                            .toString()),
                                                        double.parse(
                                                            checkouts['total']),
                                                        double.parse(checkouts[
                                                            'idShipping']),
                                                        int.parse(
                                                            checkouts['idCart']
                                                                .toString()),
                                                        formatted,
                                                        int.parse(
                                                            checkouts['idUser']
                                                                .toString()),
                                                        3);
                                                  },
                                                  child: Text(
                                                    'Đang giao',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                            )
                                          ],
                                        ),
                                        Text(
                                            'Giá: ${products[0]['priceBase']}'),
                                        Text(
                                            'Địa chỉ: ${checkouts['idShipping']}'),
                                        Text('Thanh toán khi nhận hàng'),
                                        Text('Ngày mua: $formattedDate'),
                                        Text('Tổng thanh toán: ${total}'),
                                      ],
                                    ),
                                  ),
                                ]),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: size.width,
                          height: size.height * 0.6,
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: checkoutIdUserStatus3.length,
                            itemBuilder: (context, index) {
                              var checkouts = checkoutIdUserStatus3[index];
                              var carts = filteredListCart2[index];
                              var products = productList.where((itemB) {
                                // Lấy giá trị của 'idProduct' từ itemB
                                dynamic idProductB = itemB['idProduct'];

                                // Kiểm tra xem idProductB có tồn tại trong filteredListCart1[index] hay không
                                if (filteredListCart2[index]
                                    .containsValue(idProductB)) {
                                  return true; // Điều kiện thỏa mãn
                                } else {
                                  return false; // Điều kiện không thỏa mãn
                                }
                              }).toList();
                              DateTime dateTime = DateTime.parse(
                                  checkouts['dateBuy'].toString());
                              String formattedDate =
                                  DateFormat('dd/MM/yyyy').format(dateTime);
                              String formatted =
                                  DateFormat('yyyy/MM/dd').format(dateTime);
                              double total =
                                  double.parse(carts['quantity'].toString()) *
                                      double.parse(
                                          products[0]['priceBase'].toString());
                              return Container(
                                margin: EdgeInsets.only(top: 10),
                                width: size.width,
                                height: size.height * 0.2,
                                child: Row(children: [
                                  Container(
                                    margin: EdgeInsets.all(8.0),
                                    width: size.width * 0.35,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        image: DecorationImage(
                                          image: AssetImage(
                                            'assets/images/adidas-sport-pant.jpg',
                                          ),
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
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 10.0, left: 10),
                                    width: size.width * 0.5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(products[0]['title'].toString()),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                'Số lượng: ${carts['quantity']}'),
                                            Container(
                                              decoration: BoxDecoration(
                                                  border:
                                                      Border.all(width: 0.5),
                                                  color: kColor),
                                              child: TextButton(
                                                  onPressed: () {
                                                    updateCheckout(
                                                        int.parse(checkouts[
                                                                'idCheckout']
                                                            .toString()),
                                                        double.parse(
                                                            checkouts['total']),
                                                        double.parse(checkouts[
                                                            'idShipping']),
                                                        int.parse(
                                                            checkouts['idCart']
                                                                .toString()),
                                                        formatted,
                                                        int.parse(
                                                            checkouts['idUser']
                                                                .toString()),
                                                        4);
                                                  },
                                                  child: Text(
                                                    'Đã giao',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )),
                                            )
                                          ],
                                        ),
                                        Text(
                                            'Giá: ${products[0]['priceBase']}'),
                                        Text(
                                            'Địa chỉ: ${checkouts['idShipping']}'),
                                        Text('Thanh toán khi nhận hàng'),
                                        Text('Ngày mua: $formattedDate'),
                                        Text('Tổng thanh toán: ${total}'),
                                      ],
                                    ),
                                  ),
                                ]),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: size.width,
                          height: size.height * 0.6,
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemCount: checkoutIdUserStatus4.length,
                            itemBuilder: (context, index) {
                              var checkouts = checkoutIdUserStatus4[index];
                              var carts = filteredListCart3[index];
                              var products = productList.where((itemB) {
                                // Lấy giá trị của 'idProduct' từ itemB
                                dynamic idProductB = itemB['idProduct'];

                                // Kiểm tra xem idProductB có tồn tại trong filteredListCart1[index] hay không
                                if (filteredListCart3[index]
                                    .containsValue(idProductB)) {
                                  return true; // Điều kiện thỏa mãn
                                } else {
                                  return false; // Điều kiện không thỏa mãn
                                }
                              }).toList();
                              DateTime dateTime = DateTime.parse(
                                  checkouts['dateBuy'].toString());
                              String formatted =
                                  DateFormat('yyyy/MM/dd').format(dateTime);
                              String formattedDate =
                                  DateFormat('dd/MM/yyyy').format(dateTime);
                              double total =
                                  double.parse(carts['quantity'].toString()) *
                                      double.parse(
                                          products[0]['priceBase'].toString());
                              return Container(
                                margin: EdgeInsets.only(top: 10),
                                width: size.width,
                                height: size.height * 0.2,
                                child: Row(children: [
                                  Container(
                                    margin: EdgeInsets.all(8.0),
                                    width: size.width * 0.35,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        image: DecorationImage(
                                          image: AssetImage(
                                            'assets/images/adidas-sport-pant.jpg',
                                          ),
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
                                  Container(
                                    margin:
                                        EdgeInsets.only(top: 10.0, left: 10),
                                    width: size.width * 0.5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(products[0]['title'].toString()),
                                        Text('Số lượng: ${carts['quantity']}'),
                                        Text(
                                            'Giá: ${products[0]['priceBase']}'),
                                        Text(
                                            'Địa chỉ: ${checkouts['idShipping']}'),
                                        Text('Thanh toán khi nhận hàng'),
                                        Text('Ngày mua: $formattedDate'),
                                        Text('Tổng thanh toán: ${total}'),
                                      ],
                                    ),
                                  ),
                                ]),
                              );
                            },
                          ),
                        ),
                      ])),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

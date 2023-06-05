import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:touch_app/utils/constants.dart';
import 'package:touch_app/utils/icons.dart';
import 'package:touch_app/utils/userProvider.dart';
import 'package:intl/intl.dart';
import 'package:touch_app/view/Login_SignUp/logincontent.dart';
import '../Login_SignUp/inputWidget.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
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
              .where((element) =>
                  element['idUser'] == userId && element['idStatus'] == 2)
              .toList();
          checkoutIdUserStatus3 = checkoutList
              .where((element) =>
                  element['idUser'] == userId && element['idStatus'] == 3)
              .toList();
          checkoutIdUserStatus4 = checkoutList
              .where((element) =>
                  element['idUser'] == userId && element['idStatus'] == 4)
              .toList();
          print("status2");
          print(checkoutIdUserStatus2);
          print("status3");
          print(checkoutIdUserStatus3);
          print("status4");
          print(checkoutIdUserStatus4);

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

  Future<void> fetchUsers(int? userID) async {
    var apiUrl = 'https://api-datly.phamthanhnam.com/api/users/$userID';

    try {
      var response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        setState(() {
          user = jsonDecode(response.body);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Lay thành công')),
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

  @override
  void initState() {
    super.initState();
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    int? userId = userProvider.userId;
    fetchUsers(userId);
    fetchCheckouts();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final _fullnameController = TextEditingController();
    final _emailController = TextEditingController();
    final _passwordController = TextEditingController();
    String passwordCurrcent = user != null ? user['password'] : '';
    final _phoneController = TextEditingController();
    final _addressController = TextEditingController();
    _fullnameController.text = user != null ? user['fullname'] : '';
    _emailController.text = user != null ? user['email'] : '';
    _phoneController.text = user != null ? user['phone'] : '';
    _addressController.text = user != null ? user['address'] : '';

    Future<void> updateUserData() async {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final userId = userProvider.userId;
      final token = userProvider.token;

      final url = 'https://api-datly.phamthanhnam.com/api/users/$userId';

      final body = {
        'fullname': _fullnameController.text,
        'email': _emailController.text,
        'password': passwordCurrcent,
        'phone': _phoneController.text,
        'address': _addressController.text,
      };

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      };

      try {
        final response = await http.put(
          Uri.parse(url),
          headers: headers,
          body: jsonEncode(body),
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cập nhật thành công')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Không thể cập nhật thông tin tài khoản')),
          );
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Đã xảy ra lỗi')),
        );
      }
    }

    Future<void> changePassword() async {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final userId = userProvider.userId;
      final token = userProvider.token;
      try {
        final url = 'https://api-datly.phamthanhnam.com/api/users/$userId';

        final body = {'password': _passwordController.text}.toString();

        final headers = {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        };

        final response = await http.put(
          Uri.parse(url),
          headers: headers,
          body: jsonEncode(body),
        );

        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Cập nhật thành công')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Không thể cập nhật thông tin tài khoản')),
          );
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Đã xảy ra lỗi')),
        );
      }
    }

    Future<http.Response> updateCheckout(int idCheckout, double total,
        String shipping, int idCart, String dateBuy, int idUser, int status) {
      return http.put(
        Uri.parse(
            'https://api-datly.phamthanhnam.com/api/checkouts/$idCheckout'),
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
            title: Text(
              user != null ? user['fullname'] : "fullname",
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
                                            products[0]['image'],
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
                                        Text('Kích cỡ: ${carts['size']}'),
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
                                            products[0]['image'].toString(),
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
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    'Số lượng: ${carts['quantity']}'),
                                                Text(
                                                    'Kích cỡ: ${carts['size']}'),
                                              ],
                                            ),
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
                                                        checkouts['idShipping'],
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
                                                    'Đã nhận hàng',
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
                                            products[0]['image'].toString(),
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
                                        Text('Kích cỡ: ${carts['size']}'),
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
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: SizedBox(
                      width: size.width,
                      child: Column(
                        children: [
                          const Text(
                            "Thông tin tài khoản",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 23,
                                fontWeight: FontWeight.w400),
                          ),
                          ImputWidget(
                              hint:
                                  user != null ? user['fullname'] : "fullname",
                              hintIcon: closeIcon,
                              obscureText: false,
                              controller: _fullnameController),
                          ImputWidget(
                              hint: user != null ? user['email'] : "email",
                              hintIcon: closeIcon,
                              obscureText: false,
                              controller: _emailController),
                          // ImputWidget(
                          //     hint: user != null ? user['password'] : "password",
                          //     hintIcon: closeIcon,
                          //     obscureText: false,
                          //     controller: _passwordController),
                          ImputWidget(
                              hint: user != null ? user['phone'] : "phone",
                              hintIcon: closeIcon,
                              obscureText: false,
                              controller: _phoneController),
                          ImputWidget(
                              hint: user != null ? user['address'] : "address",
                              hintIcon: closeIcon,
                              obscureText: false,
                              controller: _addressController),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(inputFieldColor),
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              shape: const StadiumBorder(),
                              elevation: 10,
                              shadowColor: const Color(inputFieldColor),
                            ),
                            onPressed: () {
                              updateUserData();
                            },
                            // onPressed: () => widget.state ==true ? logUserIn(context,widget.emailController,widget.passwordController):signUserUp(context,widget.emailController,widget.passwordController),
                            child: const Text(
                              "Cập nhật",
                              style: TextStyle(
                                color: kColor,
                                fontSize: 23,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                          Container(
                            child: Column(
                              children: [
                                ImputWidget(
                                    hint: 'password',
                                    hintIcon: closeIcon,
                                    obscureText: false,
                                    controller: _passwordController),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color(inputFieldColor),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    shape: const StadiumBorder(),
                                    elevation: 10,
                                    shadowColor: const Color(inputFieldColor),
                                  ),
                                  onPressed: () {
                                    changePassword();
                                    print(_passwordController.text);
                                  },
                                  child: const Text(
                                    "Thay đổi mật khẩu",
                                    style: TextStyle(
                                      color: kColor,
                                      fontSize: 23,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color(inputFieldColor),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    shape: const StadiumBorder(),
                                    elevation: 10,
                                    shadowColor: const Color(inputFieldColor),
                                  ),
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const LoginContentNew()));
                                    print(_passwordController.text);
                                  },
                                  child: const Text(
                                    "Đăng xuất",
                                    style: TextStyle(
                                      color: kColor,
                                      fontSize: 23,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

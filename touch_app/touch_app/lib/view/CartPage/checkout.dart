import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:touch_app/utils/constants.dart';
import 'package:touch_app/utils/icons.dart';
import 'package:touch_app/view/HomePage/Home.dart';
import 'package:touch_app/view/Login_SignUp/inputWidget.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage(
      {super.key,
      required this.total,
      required this.carts,
      this.idUser,
      required this.shipping});
  final double shipping;
  final double total;
  final List<dynamic> carts;
  final int? idUser;

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool isFetching = true;
  Future<void> postCheckout(int idCart, String shipping) async {
    DateTime now = DateTime.now();
    var mysqlDateTime = DateFormat('yyyy/MM/dd').format(now);
    print(widget.idUser);
    print(widget.total);
    print(shipping.toString());
    print(mysqlDateTime);
    print(idCart);
    final response = await http.post(
      Uri.parse('https://api-datly.phamthanhnam.com/api/checkouts/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "idStatus": 2,
        "idUser": widget.idUser,
        "total": widget.total,
        "idShipping": shipping,
        "dateBuy": mysqlDateTime,
        "type": "Thanh toán khi nhận hàng",
        "idCart": idCart
      }),
    );

    if (response.statusCode == 201) {
      print('thanh toan thanh cong ');
    } else {
      throw Exception('thanh toan that bai');
    }
  }

  Future<http.Response> updateCart(
      int idUser, int idProduct, int quantity, int idCart, String size) {
    return http.put(
      Uri.parse('https://api-datly.phamthanhnam.com/api/carts/$idCart'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'idUser': idUser,
        'idProduct': idProduct,
        'quantity': quantity,
        'code': 2,
        'size': size
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final address = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: kBackgroundColor,
        elevation: 0.5,
        automaticallyImplyLeading: false,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: kColor,
            )),
        title: Text(
          "Thanh toán",
          style: TextStyle(
              color: kColor, fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: 20,
                ),
                width: size.width,
                height: size.height * 0.65,
                decoration: BoxDecoration(border: Border.all(width: 0.1)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "   Địa chỉ nhận hàng",
                      style: TextStyle(
                          color: kColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: kColor)),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: "Địa chỉ nhận hàng",
                        ),
                        controller: address,
                      ),
                    ),
                    SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Phương thức thanh toán",
                              style: TextStyle(
                                  color: kColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              "Hiện tại cửa hàng chỉ có thể áp dụng thanh toán khi nhận hàng mong quý khách thông cảm. Cửa hàng sớm cập nhật các hình thức thanh toán khác trong thời gian sớm nhất.",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w300),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.radio_button_checked,
                                  color: Colors.blue,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  " Thanh toán khi nhận hàng",
                                  style: TextStyle(
                                      color: kColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.radio_button_off,
                                  color: kColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  " Chuyển khoản",
                                  style: TextStyle(
                                      color: kColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                Icon(Icons.credit_card_off_outlined)
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.radio_button_off,
                                  color: kColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  " Tín dụng",
                                  style: TextStyle(
                                      color: kColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                Icon(Icons.credit_card_off_rounded)
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.radio_button_off,
                                  color: kColor,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  " Ghi nợ",
                                  style: TextStyle(
                                      color: kColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400),
                                ),
                                SizedBox(
                                  width: 40,
                                ),
                                Icon(Icons.credit_card_off_rounded)
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Để đảm bảo đơn hàng được vận chuyển nhanh chóng nhất. Khách hàng vui lòng điền đúng địa chỉ nhận hàng.",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w300),
                            )
                          ],
                        ),
                      ),
                    )
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
                            widget.shipping.toString(),
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
                            widget.total.toString(),
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
                          if (address.text.isNotEmpty) {
                            for (var element in widget.carts) {
                              updateCart(
                                  element['idUser'],
                                  element['idProduct'],
                                  element['quantity'],
                                  element['idCart'],
                                  element['size']);
                            
                              postCheckout(element['idCart'], address.text);
                            }
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const HomeProduct()));
                          } else {
                            print('Chua co thong tin dia chi');
                          }
                        },
                        child: SizedBox(
                          height: 40,
                          width: size.width * 0.8,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Xác nhận đặt hàng',
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
      ),
    );
  }
}

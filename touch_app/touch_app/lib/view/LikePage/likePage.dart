// ignore_for_file: file_names
import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:touch_app/data/dataProduct.dart';
import 'package:touch_app/model/product.dart';
import 'package:touch_app/utils/constants.dart';
import 'package:touch_app/utils/userProvider.dart';
import 'package:touch_app/view/HomePage/Home.dart';
import 'package:http/http.dart' as http;

class LikePage extends StatefulWidget {
  const LikePage({super.key});

  @override
  State<LikePage> createState() => _LikePageState();
}

class _LikePageState extends State<LikePage> {
  bool isFetching = true;
  List<dynamic> likes = [];
  List<dynamic> products = [];
  List<dynamic> likeIdUser = [];
  List<dynamic> filteredList = [];

  Future<void> fetchLikeProduct() async {
    var apiUrlProduct = 'https://api-datly.phamthanhnam.com/api/products/';
    var apiUrlLike = 'https://api-datly.phamthanhnam.com/api/like/';
    try {
      var response1 = await http.get(Uri.parse(apiUrlProduct));
      var response2 = await http.get(Uri.parse(apiUrlLike));
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final userId = userProvider.userId;
      final token = userProvider.token;

      if (response1.statusCode == 200 && response2.statusCode == 200) {
        setState(() {
          products = jsonDecode(response1.body);
          likes = jsonDecode(response2.body);
          likeIdUser = likes.where((like) => like['idUser'] == userId).toList();
          print(likeIdUser);
          filteredList = products
              .where((itemB) => likeIdUser
                  .any((itemA) => itemA['idProduct'] == itemB['idProduct']))
              .toList();
          print(filteredList);
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

  Future<http.Response> deleteLike(int idLike) async {
    final http.Response response = await http.delete(
      Uri.parse('https://api-datly.phamthanhnam.com/api/like/$idLike'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print('xoa thanh cong ra khoi yeu thich');
    return response;
  }

  List<dynamic> carts = [];
  List<dynamic> cartIdUser = [];
  bool isCart = false;

  Future<void> fetchCarts(int idProduct) async {
    var apiUrl = 'https://api-datly.phamthanhnam.com/api/carts/';
    try {
      var response = await http.get(Uri.parse(apiUrl));
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final userId = userProvider.userId;
      final token = userProvider.token;

      if (response.statusCode == 200) {
        setState(() {
          carts = jsonDecode(response.body);
        });
        setState(() {
          cartIdUser = carts
              .where((carts) =>
                  carts['idUser'] == userId && carts['idProduct'] == idProduct)
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

  @override
  void initState() {
    super.initState();
    fetchLikeProduct();
  }

  @override
  Widget build(BuildContext context) {
    if (isFetching) {
      return const Center(
        child: CircularProgressIndicator(), // Hoặc tiến trình chờ khác
      );
    }

    void onDelete(dynamic data) {
      setState(() {
        if (filteredList.length == 1) {
          filteredList.clear();
        } else {
          List<dynamic> filterDelete = [];
          filterDelete = likeIdUser
              .where((like) => like['idProduct'] == data['idProduct'])
              .toList();
          int idLike = filterDelete[0]['id'];
          deleteLike(idLike);

          filteredList.removeWhere(
              (element) => element['idProduct'] == data['idProduct']);
        }
      });
    }

    Future<http.Response> updateCarts(int value) {
      int idCart = cartIdUser[0]['idCart'];
      return http.put(
        Uri.parse('https://api-datly.phamthanhnam.com/api/carts/$idCart'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, int>{
          'quantity': cartIdUser[0]['quantity'] + value,
          'idUser': cartIdUser[0]['idUser'],
          'idProduct': cartIdUser[0]['idProduct'],
          'code': cartIdUser[0]['code']
        }),
      );
    }

    Future<void> postCart(int? userId, int idProduct, int quantity) async {
      final response = await http.post(
        Uri.parse('https://api-datly.phamthanhnam.com/api/carts/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, int?>{
          'quantity': quantity,
          'idUser': userId,
          'idProduct': idProduct,
          'code': 1
        }),
      );

      if (response.statusCode == 201) {
        print('thanh cong them vao gio hang');
      } else {
        throw Exception('them vao gio hang that bai');
      }
    }

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final userId = userProvider.userId;
    final token = userProvider.token;

    List<String> sizes = ['S', 'M', 'L', 'XL', 'XXL'];
    final size = MediaQuery.of(context).size;
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
                        dynamic current = filteredList[index];
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
                                      )
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
                                            icon: const Icon(Icons.favorite),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text('₫${current['price']}'),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text('₫${current['priceBase']}'),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text('Kích cỡ: ${sizes[2]}'),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    ElevatedButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.white),
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.zero,
                                              side: BorderSide(
                                                  color: Colors.black)),
                                        ),
                                        //  elevation: MaterialStateProperty.all(0),
                                      ),
                                      onPressed: () async {
                                        String messageText;
                                        await fetchCarts(current['idProduct']);
                                        setState(() {
                                          print(isCart);
                                          if (isCart == true) {
                                            updateCarts(index);
                                            messageText =
                                                "Sản phẩm đã tồn tại trong giỏ hàng!";
                                          } else {
                                            postCart(userId,
                                                current['idProduct'], index);
                                            messageText =
                                                "Sản phẩm đã được thêm vào giỏ hàng!";
                                          }
                                          var snackBar = SnackBar(
                                              backgroundColor:
                                                  Colors.transparent,
                                              duration:
                                                  const Duration(seconds: 3),
                                              content: AwesomeSnackbarContent(
                                                  title: current['title'],
                                                  message: messageText,
                                                  contentType:
                                                      ContentType.success));
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        });
                                      },
                                      child: SizedBox(
                                        height: 20,
                                        width: size.width * 0.4,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: const [
                                            Text(
                                              'Thêm vào giỏ hàng',
                                              style: TextStyle(
                                                  color: kColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Icon(
                                              Icons.arrow_right_alt,
                                              color: kColor,
                                              size: 25,
                                            ),
                                          ],
                                        ),
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
                          'DANH SÁCH YÊU THÍCH ĐANG TRỐNG',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: kColor),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Text(
                            'Hãy thay đổi phong cách theo sở thích của bạn',
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
          ],
        ),
      ),
    );
  }
}

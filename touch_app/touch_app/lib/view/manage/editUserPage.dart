import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:touch_app/utils/constants.dart';
import 'package:touch_app/view/Login_SignUp/logincontent.dart';

import 'package:touch_app/view/manage/editUser.dart';

class EditUserPage extends StatefulWidget {
  const EditUserPage({super.key});

  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  Future<http.Response> deleteUser(String idUser) async {
    final http.Response response = await http.delete(
      Uri.parse('https://api-datly.phamthanhnam.com/api/users/$idUser'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    print(idUser);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON. After deleting,
      // you'll get an empty JSON `{}` response.
      // Don't return `null`, otherwise `snapshot.hasData`
      // will always return false on `FutureBuilder`.
      return response;
    } else {
      // If the server did not return a "200 OK response",
      // then throw an exception.
      throw Exception('Failed to delete album.');
    }
  }

  List<dynamic> users = [];

  Future<void> fetchUser() async {
    var apiUrl = 'https://api-datly.phamthanhnam.com/api/users/';

    try {
      var response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        setState(() {
          users = jsonDecode(response.body);
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
    fetchUser();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kBackgroundColor,
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
          'DANH SÁCH NGƯỜI DÙNG',
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
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            var current = users[index];
            return Container(
              height: 120,
              margin:
                  EdgeInsets.only(left: 20.0, top: 20, right: 10, bottom: 10),
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            current['email'],
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                                color: Colors.white),
                          ),
                          Text(current['fullname'],
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white)),
                          Text(current['phone'],
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white)),
                          Text(current['address'],
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
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
                            String idCurrent = current['id'].toString();
                            deleteUser(idCurrent).then((_) {
                              setState(() {
                                users.removeAt(
                                    index); // Xóa người dùng khỏi danh sách local
                              });
                            }).catchError((error) {
                              // Xử lý lỗi xóa người dùng
                              print('Error deleting user: $error');
                            });
                          },
                          child: SizedBox(
                            height: 40,
                            child: Row(
                              children: [
                                Text(
                                  'Xóa người dùng',
                                  style: TextStyle(
                                      color: kColor,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
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
                                  builder: (context) => EditUser(data: current),
                                ));
                          },
                          child: SizedBox(
                            height: 40,
                            child: Row(
                              children: [
                                Text(
                                  'Chỉnh sửa',
                                  style: TextStyle(
                                      color: kColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_right_rounded,
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
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

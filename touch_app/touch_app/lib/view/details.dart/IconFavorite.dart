import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FavoriteIcon extends StatefulWidget {
  const FavoriteIcon(this.stateLike,
      {Key? key,
      required this.idUser,
      required this.idProduct,
      required this.idLike})
      : super(key: key);
  final bool stateLike;
  final int? idUser;
  final int idProduct;
  final int idLike;

  @override
  _FavoriteIconState createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  late bool isFavorite;
  @override
  void initState() {
    super.initState();
    isFavorite = widget.stateLike;
    print(widget.idProduct);
    print(widget.idUser);
    print(widget.idLike);
  }

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
    if (isFavorite == true) {
      print('them danh sach');
      postLike();
    } else {
      deleteLike(widget.idLike);
      print('xoa danh sach');
    }
  }

  Future<void> postLike() async {
    final response = await http.post(
      Uri.parse('https://api-datly.phamthanhnam.com/api/like/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, int>{
        'idProduct': widget.idProduct,
        'idUser': widget.idUser!
      }),
    );

    if (response.statusCode == 201) {
      print('thanh cong');
    } else {
      throw Exception('that bai');
    }
  }

  Future<http.Response> deleteLike(int idLike) async {
    final http.Response response = await http.delete(
      Uri.parse('https://api-datly.phamthanhnam.com/api/like/$idLike'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    return response;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.blue : null,
        size: 35,
      ),
      onPressed: toggleFavorite,
    );
  }
}

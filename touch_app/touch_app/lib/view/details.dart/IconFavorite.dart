import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FavoriteIcon extends StatefulWidget {
  const FavoriteIcon(this.stateLike, {Key? key}) : super(key: key);
  final bool stateLike;

  @override
  _FavoriteIconState createState() => _FavoriteIconState();
}

class _FavoriteIconState extends State<FavoriteIcon> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.stateLike;
  }

  void toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red : null,
        size: 35,
      ),
      onPressed: toggleFavorite,
    );
  }
}

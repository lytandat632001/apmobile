// ignore_for_file: camel_case_types, file_names

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:touch_app/model/product.dart';
import 'package:touch_app/utils/constants.dart';

class buildCard extends StatelessWidget {
  const buildCard({
    super.key,
    required this.size,
    required this.data,
  });

  final Size size;
  final dynamic data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 7, bottom: 5),
          width: size.width * 0.6,
          height: size.height * 0.35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
            image: DecorationImage(
              image: AssetImage(data['image']),
              fit: BoxFit.cover,
            ),
            boxShadow: const [
              BoxShadow(
                offset: Offset(0, 4),
                blurRadius: 4,
                color: Color.fromARGB(61, 0, 0, 0),
              ),
            ],
          ),
        ),
        Text(
          data['title'],
          style: const TextStyle(
            color: kColor,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
      
        RatingBarIndicator(
          rating: 4.0,
          itemBuilder: (context, index) => const Icon(
            Icons.star,
            color: Colors.black87,
          ),
          itemCount: 5,
          itemSize: 23.0,
        ),
      ],
    );
  }
}

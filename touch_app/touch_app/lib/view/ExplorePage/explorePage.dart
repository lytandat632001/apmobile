// ignore_for_file: file_names

import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:touch_app/data/dataProduct.dart';
import 'package:touch_app/model/product.dart';
import 'package:touch_app/utils/constants.dart';
import 'package:touch_app/view/details.dart/details.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key, required this.data});
  final List<Product> data;
  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    itemsOnExplore = widget.data;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Center(
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm sản phẩm',
                  prefixIcon: Icon(
                    Icons.search,
                    color: kColor,
                    size: 30,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: size.width,
              height: size.height * 0.7,
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: itemsOnExplore.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.67, crossAxisCount: 2),
                itemBuilder: (context, index) {
                  Product current = itemsOnExplore[index];
                  bool containsLike = itemsOnLikes.contains(current);

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Details(data: clothing[index])),
                      );
                    },
                    child: Column(
                      children: [
                        Container(
                          width: size.width * 0.5,
                          height: size.height * 0.25,
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(current.image),
                            ),
                          ),
                        ),
                        Text(
                          current.title,
                          style: const TextStyle(
                            color: kColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          '\$${current.priceBase}',
                          style: const TextStyle(
                            color: kColor,
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        RatingBarIndicator(
                          rating: current.star,
                          itemBuilder: (context, index) => const Icon(
                            Icons.star,
                            color: Colors.black87,
                          ),
                          itemCount: 5,
                          itemSize: 23.0,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

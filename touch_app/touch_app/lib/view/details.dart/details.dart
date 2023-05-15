import 'package:animate_do/animate_do.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:touch_app/data/dataProduct.dart';
import 'package:touch_app/utils/constants.dart';

class Details extends StatefulWidget {
  const Details({super.key, required this.data});
  final dynamic data;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int selectedSize = 3;
  // int selectedColor = 0;

  @override
  Widget build(BuildContext context) {
    dynamic current = widget.data;
    bool contains = itemsOnCart.contains(current);
    bool containsLike = itemsOnLikes.contains(current);
    // bool value = containsLike;

    final size = MediaQuery.of(context).size;
    List<String> sizes = ['S', 'M', 'L', 'XL', 'XXL'];

    return Scaffold(
      backgroundColor: kBackgroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () async {
            // Navigator.pop(context);
            Navigator.of(context, rootNavigator: true).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
      ),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: size.width,
                height: size.height * 0.5,
                child: Stack(children: [
                  Hero(
                    tag: current['image'],
                    child: Container(
                      width: size.width,
                      height: size.height * 0.5,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(current['image']),
                            fit: BoxFit.cover),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                current['title'],
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: kColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              FavoriteButton(
                                iconSize: 45,
                                valueChanged: (value) {
                                  setState(() {
                                    if (containsLike == true) {
                                      value = false;
                                    } else {
                                      itemsOnLikes.add(current);
                                      value = true;
                                    }
                                  });
                                },
                                isFavorite: false,
                                iconColor: Colors.blue,
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Text('₫${current['price']}',
                                style: const TextStyle(
                                    fontSize: 20, color: kColor)),
                            const SizedBox(width: 40),
                            Text(current['nameCategory'],
                                style: const TextStyle(
                                    fontSize: 18, color: kColor)),
                            const SizedBox(width: 40),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 20),
                          child: Row(
                            children: [
                              Text('₫${current['priceBase']}',
                                  style: const TextStyle(
                                      fontSize: 20, color: kColor)),
                              const SizedBox(width: 40),
                            ],
                          ),
                        ),
                        FadeInUp(
                          delay: const Duration(milliseconds: 500),
                          child: SizedBox(
                            // color: Colors.red,
                            width: size.width * 0.9,
                            height: size.height * 0.08,
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: sizes.length,
                                itemBuilder: (ctx, index) {
                                  var current = sizes[index];
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedSize = index;
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          right: 15, bottom: 8, top: 8),
                                      child: AnimatedContainer(
                                        width: size.width * 0.12,
                                        decoration: BoxDecoration(
                                          color: selectedSize == index
                                              ? kLinkColor
                                              : kBackgroundColor,
                                          border: Border.all(
                                              color: kColor, width: 2),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        duration:
                                            const Duration(milliseconds: 200),
                                        child: Center(
                                          child: Text(
                                            current,
                                            style: TextStyle(
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500,
                                                color: selectedSize == index
                                                    ? Colors.white
                                                    : Colors.black),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
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
                              String messageText;
                              setState(() {
                                // AddToCart.addToCart(current, context);

                                if (contains == true) {
                                  messageText =
                                      "Sản phẩm đã tồn tại trong giỏ hàng!";
                                } else {
                                  itemsOnCart.add(current);
                                  messageText =
                                      "Sản phẩm đã được thêm vào giỏ hàng!";
                                }

                                var snackBar = SnackBar(
                                    backgroundColor: Colors.transparent,
                                    duration: const Duration(seconds: 3),
                                    content: AwesomeSnackbarContent(
                                        title: current['title'],
                                        message: messageText,
                                        contentType: ContentType.success));
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              });
                            },
                            child: SizedBox(
                              height: 40,
                              width: size.width * 0.7,
                              child: const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'THÊM VÀO GIỎ',
                                    style: TextStyle(
                                        color: kColor,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Icon(
                                    Icons.shopping_bag_outlined,
                                    color: kColor,
                                    size: 25,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'MIÊU TẢ SẢN PHẨM',
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: size.width * 0.8,
                                  child: Text('${current['description']}',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          color: kColor,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('XẾP HẠNG & ĐÁNH GIÁ',
                                  style: TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold)),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, bottom: 10),
                                child: Row(
                                  children: [
                                    Text(current['star'],
                                        style: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold)),
                                    const SizedBox(
                                      width: 100,
                                    ),
                                    Text(current['review'],
                                        style: const TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              RatingBarIndicator(
                                rating: 4.5,
                                itemBuilder: (context, index) => const Icon(
                                  Icons.star,
                                  color: Colors.black87,
                                ),
                                itemCount: 5,
                                itemSize: 30,
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

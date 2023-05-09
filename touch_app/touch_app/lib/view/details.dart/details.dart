import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:touch_app/bloc/addToCart/addToCartBloc.dart';
import 'package:touch_app/bloc/addToCart/addToCartEvent.dart';
import 'package:touch_app/model/product.dart';
import 'package:touch_app/utils/constants.dart';
import 'package:touch_app/view/CartPage/addToCart.dart';

class Details extends StatefulWidget {
  const Details({super.key, required this.data});
  final Product data;

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  int selectedSize = 3;
  int selectedColor = 0;
  @override
  Widget build(BuildContext context) {
    Product current = widget.data;
    final size = MediaQuery.of(context).size;
    List<String> sizes = ['S', 'M', 'L', 'XL', 'XXL'];
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
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
                    tag: current.image,
                    child: Container(
                      width: size.width,
                      height: size.height * 0.5,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(current.image),
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
                                current.title,
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: kColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.favorite_border_outlined,
                                    size: 25,
                                  ))
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Text('₫${current.price}0.000',
                                style: const TextStyle(
                                    fontSize: 20, color: kColor)),
                            const SizedBox(width: 40),
                            Text(current.category,
                                style: const TextStyle(
                                    fontSize: 18, color: kColor)),
                            const SizedBox(width: 40),
                            Text(current.subCategory,
                                style: const TextStyle(
                                    fontSize: 19, color: kColor)),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 20),
                          child: Row(
                            children: [
                              Text('₫${current.priceBase}0.000',
                                  style: const TextStyle(
                                      fontSize: 20, color: kColor)),
                              const SizedBox(width: 40),
                              Text('-${current.voucher}%',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
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
                              setState(() {
                                AddToCart.addToCart(current, context);
                              });

                              // final cartBloc = context.read<CartBloc>();
                              // cartBloc.add(AddToCartBloc(data: current));
                              // ScaffoldMessenger.of(context)
                              //     .showSnackBar(const SnackBar(
                              //   content: Text('Product added To Cart'),
                              //   duration: Duration(seconds: 2),
                              // ));
                            },
                            child: SizedBox(
                              height: 40,
                              width: size.width * 0.7,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: const [
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
                                  child: Text(
                                      '${current.description} ${current.description}',
                                      style: const TextStyle(
                                          fontSize: 18,
                                          color: kColor,
                                          fontWeight: FontWeight.w500)),
                                ),
                              ],
                            )),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: SizedBox(
                            width: size.width,
                            height: size.height * 0.15,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('XẾP HẠNG & ĐÁNH GIÁ',
                                    style: TextStyle(
                                        fontSize: 23,
                                        fontWeight: FontWeight.bold)),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: Row(
                                    children: [
                                      Text(current.star.toString(),
                                          style: const TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(
                                        width: 100,
                                      ),
                                      Text(current.review,
                                          style: const TextStyle(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ),
                                RatingBarIndicator(
                                  rating: current.star,
                                  itemBuilder: (context, index) => const Icon(
                                    Icons.star,
                                    color: Colors.black87,
                                  ),
                                  itemCount: 5,
                                  itemSize: 30,
                                )
                              ],
                            ),
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

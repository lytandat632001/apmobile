import 'package:flutter/material.dart';
import 'package:touch_app/data/dataProduct.dart';
import 'package:touch_app/model/product.dart';
import 'package:touch_app/utils/constants.dart';
import 'package:touch_app/view/HomePage/Home.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double calculateTotalPrice() {
    double total = 0.0;
    if (itemsOnCart.isEmpty) {
      total = 0;
    } else {
      for (Product data in itemsOnCart) {
        total = total + data.priceBase * data.value;
      }
    }
    return total;
  }

  double calculateShipping() {
    double shipping = 0.0;
    if (itemsOnCart.isEmpty) {
      shipping = 0.0;
      return shipping;
    } else if (itemsOnCart.length <= 3) {
      shipping = 30;
      return shipping;
    } else {
      shipping = 60;
      return shipping;
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> sizes = ['S', 'M', 'L', 'XL', 'XXL'];
    final size = MediaQuery.of(context).size;
    void onDelete(Product data) {
      setState(() {
        if (itemsOnCart.length == 1) {
          itemsOnCart.clear();
        } else {
          itemsOnCart
              .removeWhere((element) => element.idProduct == data.idProduct);
        }
      });
    }

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
              child: itemsOnCart.isNotEmpty
                  ? ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemCount: itemsOnCart.length,
                      itemBuilder: (context, index) {
                        var current = itemsOnCart[index];
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
                                      image:
                                          AssetImage(itemsOnCart[index].image),
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
                                            current.title,
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w400),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              onDelete(current);
                                            },
                                            icon: const Icon(Icons.close),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text('₫${current.price}'),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text('₫${current.priceBase}'),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text('Kích cỡ: ${sizes[2]}'),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    SizedBox(
                                      width: size.width * 0.2,
                                      height: size.height * 0.04,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                if (current.value > 1) {
                                                  current.value--;
                                                } else {
                                                  onDelete(current);
                                                  current.value = 1;
                                                }
                                              });
                                            },
                                            child: const Icon(
                                              Icons.remove_circle_outline,
                                              color: kColor,
                                              size: 25,
                                            ),
                                          ),
                                          Text(
                                            current.value.toString(),
                                            style: const TextStyle(
                                                color: kColor,
                                                fontWeight: FontWeight.w400,
                                                fontSize: 18),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                current.value >= 0
                                                    ? current.value++
                                                    : null;
                                              });
                                            },
                                            child: const Icon(
                                              Icons.add_circle_outline_outlined,
                                              color: kColor,
                                              size: 25,
                                            ),
                                          ),
                                        ],
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
                          'GIỎ HÀNG CỦA BẠN ĐANG TRỐNG',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: kColor),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Text(
                            'Hãy thể hiện cho mình một phong cách sáng tạo',
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
                          calculateTotalPrice().toString(),
                          style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
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
                          calculateShipping().toString(),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeProduct(),
                            ));
                      },
                      child: SizedBox(
                        height: 40,
                        width: size.width * 0.8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Thanh toán',
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

// ignore_for_file: file_names
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:touch_app/data/dataProduct.dart';
import 'package:touch_app/model/product.dart';
import 'package:touch_app/utils/constants.dart';
import 'package:touch_app/view/HomePage/Home.dart';

class LikePage extends StatefulWidget {
  const LikePage({super.key});

  @override
  State<LikePage> createState() => _LikePageState();
}

class _LikePageState extends State<LikePage> {
  @override
  Widget build(BuildContext context) {
    List<String> sizes = ['S', 'M', 'L', 'XL', 'XXL'];
    final size = MediaQuery.of(context).size;
    void onDelete(dynamic data) {
      setState(() {
        if (itemsOnLikes.length == 1) {
          itemsOnLikes.clear();
        } else {
          itemsOnLikes(element) => element['idProduct'] == data['idProduct'];
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
              child: itemsOnLikes.isNotEmpty
                  ? ListView.builder(
                      scrollDirection: Axis.vertical,
                      physics: const BouncingScrollPhysics(),
                      itemCount: itemsOnLikes.length,
                      itemBuilder: (context, index) {
                        dynamic current = itemsOnLikes[index];
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
                                      image: AssetImage(
                                          itemsOnLikes[index]['image']),
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
                                      onPressed: () {
                                        String messageText;
                                        print(current['title']);

                                        setState(() {
                                          if (itemsOnCart.contains(current) ==
                                              true) {
                                            messageText =
                                                "Sản phẩm đã tồn tại trong giỏ hàng!";
                                          } else {
                                            itemsOnCart.add(current);
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

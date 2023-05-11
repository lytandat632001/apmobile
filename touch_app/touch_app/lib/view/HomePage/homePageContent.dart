// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: file_names, unused_local_variable, no_leading_underscores_for_local_identifiers, unused_element, avoid_print, camel_case_types

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_multi_select_items/flutter_multi_select_items.dart';

import 'package:touch_app/data/dataProduct.dart';
import 'package:touch_app/model/product.dart';
import 'package:touch_app/utils/constants.dart';
import 'package:touch_app/view/ExplorePage/explorePage.dart';
import 'package:touch_app/view/details.dart/details.dart';

import 'buildCard.dart';
import 'iconCheck.dart';
import 'modal.dart';

class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    late PageController _controllerClothing =
        PageController(initialPage: 1, viewportFraction: 0.7);
    late PageController _controllerAccessories =
        PageController(initialPage: 1, viewportFraction: 0.7);
    late PageController _controllerShoes =
        PageController(initialPage: 1, viewportFraction: 0.7);
    List<Modal> titleBottomSheet = [
      Modal(name: "Nữ", isSelected: true),
      Modal(name: "Nam", isSelected: false),
      Modal(name: "Trẻ em", isSelected: false)
    ];
    bool isFavorite = false;

    List<bool> temp = [true, false, false];

    // String value = 'flutter';
    // List<S2Choice<String>> options = [
    //   S2Choice<String>(value: 'Nữ', title: 'Nữ'),
    //   S2Choice<String>(value: 'Nam', title: 'Nam'),
    //   S2Choice<String>(value: 'Trẻ em', title: 'Trẻ em'),
    // ];
    int selected = 0;
    List<String> tags = [];
    List<String> options = ["Nữ", "Nam", "Trẻ em"];
    String? _selected;

    @override
    void dispose() {
      _controllerClothing.dispose();
      _controllerAccessories.dispose();
      _controllerShoes.dispose();

      super.dispose();
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: FadeInUp(
                    delay: const Duration(milliseconds: 200),
                    child: Row(
                      children: [
                        // Container(
                        //   height: 32,
                        //   decoration: BoxDecoration(
                        //     border: Border.all(width: 1.0),
                        //   ),
                        //   child: ElevatedButton(
                        //     style: ElevatedButton.styleFrom(
                        //         foregroundColor: Colors.black87,
                        //         backgroundColor: kBackgroundColor,
                        //         elevation: 0),
                        //     onPressed: () {
                        //       showModalBottomSheet(
                        //         context: context,
                        //         builder: (context) {
                        //           return SizedBox(
                        //             width: size.width,
                        //             height: size.height * 0.3,
                        //             child: Padding(
                        //               padding: const EdgeInsets.all(15.0),
                        //               child: Column(
                        //                 mainAxisAlignment:
                        //                     MainAxisAlignment.spaceAround,
                        //                 children: [
                        //                   /// Title
                        //                   Row(
                        //                     mainAxisAlignment:
                        //                         MainAxisAlignment.spaceBetween,
                        //                     children: [
                        //                       const Text(
                        //                         'LỌC THEO DANH MỤC',
                        //                         style: TextStyle(
                        //                             fontSize: 22,
                        //                             fontWeight: FontWeight.w800,
                        //                             color: kColor),
                        //                       ),
                        //                       IconButton(
                        //                           onPressed: () {
                        //                             Navigator.pop(context);
                        //                           },
                        //                           icon: const Icon(
                        //                             Icons.close,
                        //                             color: kColor,
                        //                             size: 30,
                        //                           )),
                        //                     ],
                        //                   ),

                        //                   Wrap(
                        //                     direction: Axis.horizontal,
                        //                     children: List.generate(
                        //                       titleBottomSheet.length,
                        //                       (index) {
                        //                         return InkWell(
                        //                           onTap: () {
                        //                             setState(() {
                        //                               _update(titleBottomSheet,
                        //                                   index);
                        //                             });
                        //                             print(
                        //                                 titleBottomSheet[index]
                        //                                     .isSelected);
                        //                           },
                        //                           child: Column(
                        //                             mainAxisAlignment:
                        //                                 MainAxisAlignment
                        //                                     .spaceAround,
                        //                             children: [
                        //                               IconCheck(
                        //                                   titleBottomSheet:
                        //                                       titleBottomSheet[
                        //                                               index]
                        //                                           .name,
                        //                                   isSelected:
                        //                                       temp[index]),
                        //                               // Row(
                        //                               //   children: [
                        //                               //     Text(
                        //                               //       titleBottomSheet[
                        //                               //               index]
                        //                               //           .name,
                        //                               //       style: const TextStyle(
                        //                               //           color: kColor,
                        //                               //           fontSize: 16,
                        //                               //           fontWeight:
                        //                               //               FontWeight
                        //                               //                   .w400),
                        //                               //     ),
                        //                               //     Icon(
                        //                               //       Icons.check,
                        //                               //       color: (titleBottomSheet[
                        //                               //                       index]
                        //                               //                   .isSelected ==
                        //                               //               true)
                        //                               //           ? Colors.black
                        //                               //           : Colors
                        //                               //               .transparent,
                        //                               //     ),
                        //                               //   ],
                        //                               // ),
                        //                             ],
                        //                           ),
                        //                         );
                        //                       },
                        //                     ),
                        //                   ),
                        //                 ],
                        //               ),
                        //             ),
                        //           );
                        //         },
                        //       );
                        //     },
                        //     child: Row(
                        //       children: const [
                        //         Text(
                        //           'TRẺ EM',
                        //           style: TextStyle(
                        //               color: kColor,
                        //               fontSize: 14,
                        //               fontWeight: FontWeight.bold),
                        //         ),
                        //         Icon(
                        //           Icons.expand_more,
                        //           size: 25,
                        //           color: kColor,
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.only(left: 40.0),
                        //   child: SizedBox(
                        //     height: 40,
                        //     child: MultiSelectContainer(
                        //         textStyles: const MultiSelectTextStyles(
                        //             textStyle: TextStyle(
                        //                 color: Colors.grey,
                        //                 fontSize: 15,
                        //                 fontWeight: FontWeight.w400),
                        //             selectedTextStyle: TextStyle(
                        //                 color: kColor,
                        //                 fontSize: 15,
                        //                 fontWeight: FontWeight.w400)),
                        //         isMaxSelectableWithPerpetualSelects: true,
                        //         showInListView: true,
                        //         listViewSettings: ListViewSettings(
                        //             scrollDirection: Axis.horizontal,
                        //             separatorBuilder: (_, __) => const SizedBox(
                        //                   width: 10,
                        //                 )),
                        //         itemsDecoration: MultiSelectDecorations(
                        //           decoration: BoxDecoration(
                        //             border: Border.all(
                        //                 width: 1.0, color: Colors.grey),
                        //             color: kBackgroundColor,
                        //           ),
                        //           // disabledDecoration: BoxDecoration(
                        //           //   color: Colors.black,
                        //           //   border: Border.all(
                        //           //       width: 1.0, color: Colors.black45),
                        //           // ),
                        //           selectedDecoration: BoxDecoration(
                        //             color: kBackgroundColor,
                        //             border: Border.all(
                        //                 width: 1.0, color: kPrimaryColor),
                        //           ),
                        //         ),
                        //         items: [
                        //           MultiSelectCard(
                        //               value: 'Hat',
                        //               label: 'Hat',
                        //               selected: true),
                        //           MultiSelectCard(
                        //               value: 'Clothing',
                        //               label: 'Clothing',
                        //               selected: true),
                        //           MultiSelectCard(
                        //               value: 'Accessories',
                        //               label: 'Accessories',
                        //               selected: true),
                        //           MultiSelectCard(
                        //               value: 'Shoes',
                        //               label: 'Shoes',
                        //               selected: true),
                        //           MultiSelectCard(
                        //               value: 'Socks',
                        //               label: 'Socks',
                        //               selected: true),
                        //         ],
                        //         onChange: (allSelectedItems, selectedItem) {
                        //           print(allSelectedItems);
                        //         }),
                        //   ),
                        // )
                      ],
                    ),
                  ),
                ),
              ),

              //Clothing

              FadeInUp(
                delay: const Duration(milliseconds: 300),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            clothing[0].subCategory,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: kColor),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ExplorePage(
                                      data: clothing,
                                    ),
                                  ));
                            },
                            child: const Text(
                              "See all",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: kColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: size.width,
                      height: size.height * 0.5,
                      color: kBackgroundColor,
                      child: PageView.builder(
                        controller: _controllerClothing,
                        physics: const BouncingScrollPhysics(),
                        itemCount: clothing.length,
                        itemBuilder: (context, index) {
                          Product data = clothing[index];
                          return GestureDetector(
                            onTap: () {
                              print(data.title);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Details(data: clothing[index])),
                              );
                            },
                            child: view(index, size, _controllerClothing, data),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              ////Accessories
              FadeInUp(
                delay: const Duration(milliseconds: 300),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            accessories[0].subCategory,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: kColor),
                          ),
                          GestureDetector(
                            onTap: () {
                              print('See all');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ExplorePage(
                                      data: accessories,
                                    ),
                                  ));
                            },
                            child: const Text(
                              "See all",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: kColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: size.width,
                      height: size.height * 0.5,
                      color: kBackgroundColor,
                      child: PageView.builder(
                        controller: _controllerAccessories,
                        physics: const BouncingScrollPhysics(),
                        itemCount: accessories.length,
                        itemBuilder: (context, index) {
                          Product data = accessories[index];
                          return GestureDetector(
                            onTap: () {
                              print(data.title);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Details(data: accessories[index])),
                              );
                            },
                            child:
                                view(index, size, _controllerAccessories, data),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),

              /// Shoes
              FadeInUp(
                delay: const Duration(milliseconds: 300),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            shoes[0].subCategory,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: kColor),
                          ),
                          GestureDetector(
                            onTap: () {
                              print('See all');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ExplorePage(
                                      data: shoes,
                                    ),
                                  ));
                            },
                            child: const Text(
                              "See all",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: kColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      width: size.width,
                      height: size.height * 0.5,
                      color: kBackgroundColor,
                      child: PageView.builder(
                        controller: _controllerShoes,
                        physics: const BouncingScrollPhysics(),
                        itemCount: shoes.length,
                        itemBuilder: (context, index) {
                          Product data = shoes[index];
                          return GestureDetector(
                              onTap: () {
                                print(data.title);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Details(data: shoes[index])),
                                );
                              },
                              child: view(index, size, _controllerShoes, data));
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget view(int index, Size size, PageController _controller, Product data) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          double value = 0.0;
          if (_controller.position.haveDimensions) {
            value = index.toDouble() - (_controller.page ?? 0);
            value = (value * 0.04).clamp(-1, 1);
          }
          return Transform.rotate(
            angle: 3.14 * value,
            child: buildCard(
              size: size,
              data: data,
            ),
          );
        });
  }
}

Future<bool> _update(List<Modal> a, int i) async {
  for (var element in a) {
    element.isSelected = false;
  }
  return a[i].isSelected = true;
}

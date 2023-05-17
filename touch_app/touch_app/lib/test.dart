// // // import 'package:flutter/material.dart';

// // // import 'package:provider/provider.dart';

// // // import 'package:touch_app/utils/userProvider.dart';

// // // class ProductListPage extends StatefulWidget {
// // //   @override
// // //   _ProductListPageState createState() => _ProductListPageState();
// // // }

// // // class _ProductListPageState extends State<ProductListPage> {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     UserProvider userProvider = Provider.of<UserProvider>(context);
// // //     int? userId = userProvider.userId;
// // //     String? token = userProvider.token;
// // //     return Scaffold(
// // //       body: Center(
// // //         child: Column(
// // //           children: [
// // //             Text('${userId}'),
// // //             Text('${token}'),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:provider/provider.dart';
// import 'package:touch_app/model/product.dart';
// import 'package:touch_app/utils/userProvider.dart';

// class ProductListPage extends StatefulWidget {
//   const ProductListPage({super.key});

//   @override
//   _ProductListPageState createState() => _ProductListPageState();
// }

// class _ProductListPageState extends State<ProductListPage> {
//   final List<dynamic> productList = [
//     'Apple',
//     'Banana',
//     'Orange',
//     'Grapes',
//     'Mango',
//   ];

//   List<dynamic> searchProducts(List<dynamic> productList, String searchTerm) {
//     List<dynamic> results = [];

//     for (var product in productList) {
//       if (product.toString().toLowerCase().contains(searchTerm.toLowerCase())) {
//         results.add(product);
//       }
//     }

//     return results;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Product Search'),
//         ),
//         body: Column(
//           children: [
//             SearchBar(
//               onChanged: (searchTerm) {
//                 List<dynamic> searchResults =
//                     searchProducts(productList, searchTerm);
//                 // Xử lý kết quả tìm kiếm ở đây (hiển thị, cập nhật UI, vv.)
//                 print(searchResults);
//               },
//             ),
//             // Các widget khác trong body...
//           ],
//         ),
//       ),
//     );
//   }
// }

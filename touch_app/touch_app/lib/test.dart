// // import 'package:flutter/material.dart';

// // import 'package:provider/provider.dart';

// // import 'package:touch_app/utils/userProvider.dart';

// // class ProductListPage extends StatefulWidget {
// //   @override
// //   _ProductListPageState createState() => _ProductListPageState();
// // }

// // class _ProductListPageState extends State<ProductListPage> {
// //   @override
// //   Widget build(BuildContext context) {
// //     UserProvider userProvider = Provider.of<UserProvider>(context);
// //     int? userId = userProvider.userId;
// //     String? token = userProvider.token;
// //     return Scaffold(
// //       body: Center(
// //         child: Column(
// //           children: [
// //             Text('${userId}'),
// //             Text('${token}'),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
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
//   dynamic user;

//   Future<void> fetchUsers(int? userID) async {
//     var apiUrl = 'https://api-datly.phamthanhnam.com/api/users/$userID';

//     try {
//       var response = await http.get(Uri.parse(apiUrl));

//       if (response.statusCode == 200) {
//         setState(() {
//           user = jsonDecode(response.body);
//         });
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Lay thành công')),
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Không thể lấy danh sách sản phẩm')),
//         );
//       }
//     } catch (error) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Đã xảy ra lỗi')),
//       );
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     UserProvider userProvider =
//         Provider.of<UserProvider>(context, listen: false);
//     int? userId = userProvider.userId;
//     fetchUsers(userId);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Danh sách sản phẩm')),
//       // body: ListView.builder(
//       //   itemCount: user.length,
//       //   itemBuilder: (context, index) {
//       //     var product = user[index];

//       //     return Column(
//       //       children: [
//       //         Text(user['email']),
//       //         // Text('Giá: ${product['price']}'),
//       //         // Image.asset(user['email']),
//       //       ],
//       //     );
//       //   },
//       // ),
//       body: user != null ? Text(user['email']) : Text('Kh lay dc'),
//     );
//   }
// }

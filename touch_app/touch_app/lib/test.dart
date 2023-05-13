// import 'package:flutter/material.dart';
// import 'package:get/get_connect/http/src/status/http_status.dart';
// import 'package:touch_app/testapi.dart';
// import 'package:http/http.dart' as http;
// import 'dart:io';

// class Test extends StatefulWidget {
//   const Test({super.key});

//   @override
//   State<Test> createState() => _TestState();
// }

// class _TestState extends State<Test> {
//   late UserAPI userAPI;
//   bool isDataLoaded = false;
//   String errorMsg = "";
//   Future<UserAPI> getDataFromAPI() async {
//     Uri url = Uri.parse("http://10.0.8.1:8080/api/users");
//     var response = await http.get(url);
//     if (response.statusCode == HttpStatus.ok) {
//       UserAPI userAPI = userAPIFromJson(response.body);
//       return userAPI;
//     } else {
//       errorMsg = '${response.statusCode}:${response.body}';
//       return UserAPI(data: []);
//     }
//   }

//   assignData() async {
//     userAPI = await getDataFromAPI();
//     setState(() {
//       isDataLoaded = true;
//     });
//   }

//   @override
//   void initState() {
//     assignData();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: !isDataLoaded
//             ? const Center(
//                 child: CircularProgressIndicator(),
//               )
//             : errorMsg.isNotEmpty
//                 ? Center(
//                     child: Text(errorMsg),
//                   )
//                 : userAPI.data.isEmpty
//                     ? const Text('No Data')
//                     : ListView.builder(
//                         itemBuilder: (context, index) => getMyRow(index),
//                       ));
//   }

//   Widget getMyRow(int index) {
//     return Card(
//       child: ListTile(
//         title: Text(userAPI.data[index].fullname),
//       ),
//     );
//   }
// }

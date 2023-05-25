// // To parse this JSON data, do
// //
// //     final userApi = userApiFromJson(jsonString);

// import 'dart:convert';

// List<UserApi> userApiFromJson(String str) => List<UserApi>.from(json.decode(str).map((x) => UserApi.fromJson(x)));

// String userApiToJson(List<UserApi> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

// class UserApi {
//     int id;
//     String email;
//     String password;
//     String fullname;
//     String phone;
//     String address;

//     UserApi({
//         required this.id,
//         required this.email,
//         required this.password,
//         required this.fullname,
//         required this.phone,
//         required this.address,
//     });

//     factory UserApi.fromJson(Map<String, dynamic> json) => UserApi(
//         id: json["id"],
//         email: json["email"],
//         password: json["password"],
//         fullname: json["fullname"],
//         phone: json["phone"],
//         address: json["address"],
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "email": email,
//         "password": password,
//         "fullname": fullname,
//         "phone": phone,
//         "address": address,
//     };
// }

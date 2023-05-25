// import 'dart:convert';

// import 'package:http/http.dart';

// import '../model/new.dart';

// Future<NewProduct> GetProduct() async {
//   String url = "https://api-datly.phamthanhnam.com/api/products";
//   Response response = await get(Uri.parse(url));
//   // data sample trả về trong response
//   int statusCode = response.statusCode;
//   Map<String, String> headers = response.headers;
//   String json = response.body;
//   NewProduct data = NewProduct.fromJson(jsonDecode(json));
//   // print(data.image!.data);
//   return data;
// }

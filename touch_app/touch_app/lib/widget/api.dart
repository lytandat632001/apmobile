import 'package:http/http.dart';

class UserRespon {
  String a = "https://jatinderji.github.io/users_pets_api/users_pets.json";
  getUser() async {
    Response response = await get(Uri.parse(a));
  }
}

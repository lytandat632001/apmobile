// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  late int idUser;
  late String email;
  late String password;
  late String fullname;
  late String phone;
  late String address;
  set setidUser(int idUser) => this.idUser = idUser;
  get getidUser => this.idUser;

  set setemail(String email) => this.email = email;
  get getemail => this.email;

  set setpassword(String password) => this.password = password;
  get getpassword => this.password;

  set setfullname(String fullname) => this.fullname = fullname;
  get getfullname => this.fullname;

  set setphone(String phone) => this.phone = phone;
  get getphone => this.phone;

  set setaddress(String address) => this.address = address;
  get getaddress => this.address;
  User({
    required this.idUser,
    required this.email,
    required this.password,
    required this.fullname,
    required this.phone,
    required this.address,
  });
}

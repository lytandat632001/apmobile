// ignore_for_file: public_member_api_docs, sort_constructors_first
class Product {
  late final int idProduct;
  final String title;
  final String description;
  final String image;
  final double price;
  final double priceBase;
  final String category;
  final String subCategory;
  final String voucher;
  final String review;
  final double star;
   int value;
  Product(
      {required this.idProduct,
      required this.title,
      required this.description,
      required this.image,
      required this.price,
      required this.priceBase,
      required this.category,
      required this.subCategory,
      required this.voucher,
      required this.review,
      required this.star,
      required this.value});
}

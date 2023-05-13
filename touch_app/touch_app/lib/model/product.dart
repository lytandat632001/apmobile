// class Product {
//   late final int idProduct;
//   final String title;
//   final String description;
//   final String image;
//   final double price;
//   final double priceBase;
//   final String idCategory;
//   final String review;
//   final double star;
//   Product(this.title, this.description, this.image, this.price, this.priceBase,
//       this.idCategory, this.review, this.star);
      
// }
class Product {
  late final int idProduct;
  final String title;
  final String description;
  final String image;
  final double price;
  final double priceBase;
  final String idCategory;
  final String review;
  final double star;

  Product({
    required this.title,
    required this.description,
    required this.image,
    required this.price,
    required this.priceBase,
    required this.idCategory,
    required this.review,
    required this.star,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      title: json['title'],
      description: json['description'],
      image: json['image'],
      price: json['price'],
      priceBase: json['priceBase'],
      idCategory: json['idCategory'],
      review: json['review'],
      star: json['star'],
    );
  }
}
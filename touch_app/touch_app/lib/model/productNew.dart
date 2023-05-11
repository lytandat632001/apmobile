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
  Product(this.title, this.description, this.image, this.price, this.priceBase,
      this.idCategory, this.review, this.star);
}

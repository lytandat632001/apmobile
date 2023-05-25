class NewProduct {
  int? idProduct;
  String? title;
  String? description;
  Image? image;
  String? price;
  String? priceBase;
  int? idCategory;
  String? review;
  String? star;
  String? nameCategory;

  NewProduct(
      {this.idProduct,
      this.title,
      this.description,
      this.image,
      this.price,
      this.priceBase,
      this.idCategory,
      this.review,
      this.star,
      this.nameCategory});

  NewProduct.fromJson(Map<String, dynamic> json) {
    idProduct = json['idProduct'];
    title = json['title'];
    description = json['description'];
    image = json['image'] != null ? new Image.fromJson(json['image']) : null;
    price = json['price'];
    priceBase = json['priceBase'];
    idCategory = json['idCategory'];
    review = json['review'];
    star = json['star'];
    nameCategory = json['nameCategory'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['idProduct'] = this.idProduct;
    data['title'] = this.title;
    data['description'] = this.description;
    if (this.image != null) {
      data['image'] = this.image!.toJson();
    }
    data['price'] = this.price;
    data['priceBase'] = this.priceBase;
    data['idCategory'] = this.idCategory;
    data['review'] = this.review;
    data['star'] = this.star;
    data['nameCategory'] = this.nameCategory;
    return data;
  }
}

class Image {
  String? type;
  List<int>? data;

  Image({this.type, this.data});

  Image.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    data = json['data'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['data'] = this.data;
    return data;
  }
}
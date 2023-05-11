// ignore_for_file: public_member_api_docs, sort_constructors_first
class checkout {
  late final int idCheckout;
  final double total;
  final double idShipping;
  final DateTime dateBuy;
  final String type;
  final int idCart;
  checkout({
    required this.idCheckout,
    required this.total,
    required this.idShipping,
    required this.dateBuy,
    required this.type,
    required this.idCart,
  });
}

// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:touch_app/model/product.dart';
import 'package:touch_app/view/CartPage/addToCart.dart';

abstract class CartEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddToCartBloc extends CartEvent {
  final Product data;
  AddToCartBloc({
    required this.data,
  });
   @override
  List<Object> get props => [data];
  
}

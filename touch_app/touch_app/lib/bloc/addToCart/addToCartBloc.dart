import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:touch_app/bloc/addToCart/addToCartEvent.dart';
import 'package:touch_app/bloc/addToCart/addToCartState.dart';
import 'package:touch_app/model/product.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState([])) {
    on<CartEvent>(_mapEventToState);
  }

  Future<void> _mapEventToState(
      CartEvent event, Emitter<CartState> emit) async {
    if (event is AddToCartBloc) {
      final updatedCart = List<Product>.from(state.cartItems)..add(event.data);
      emit(CartState(updatedCart));
    } else {}
  }
}

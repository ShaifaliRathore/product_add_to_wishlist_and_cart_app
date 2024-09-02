import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wishlist_cart_product/cart/bloc/cart_event.dart';
import 'package:wishlist_cart_product/cart/bloc/cart_state.dart';
import 'package:wishlist_cart_product/data/cart_products.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitialState()) {
    on<CartInitialEvent>(cartInitialEvent);
    on<RemoveProductFromCartEvent>(removeProductFromCartEvent);
  }

  FutureOr<void> cartInitialEvent(
      CartInitialEvent event, Emitter<CartState> emit) {
    emit(CartLoadedState(cartProducts: cartProdcuts));
  }

  FutureOr<void> removeProductFromCartEvent(
      RemoveProductFromCartEvent event, Emitter<CartState> emit) {
    cartProdcuts.remove(event.removeProduct);
    emit(CartLoadedState(cartProducts: cartProdcuts));
    emit(RemovedProdcutFromCartState());
  }
}

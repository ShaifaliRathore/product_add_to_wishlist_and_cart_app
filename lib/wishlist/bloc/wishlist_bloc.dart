import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wishlist_cart_product/data/wishlist_products.dart';
import 'package:wishlist_cart_product/wishlist/bloc/wishlist_event.dart';
import 'package:wishlist_cart_product/wishlist/bloc/wishlist_state.dart';

class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitialState()) {
    on<WishlistInitialEvent>(wishlistInitialEvent);
    on<RemoveProductFromWishlistEvent>(removeProductFromWishlistEvent);
  }

  FutureOr<void> wishlistInitialEvent(
      WishlistInitialEvent event, Emitter<WishlistState> emit) {
    emit(WishlistLoadedState(wishlistProducts: wishlistedProducts));
  }

  FutureOr<void> removeProductFromWishlistEvent(
      RemoveProductFromWishlistEvent event, Emitter<WishlistState> emit) {
    wishlistedProducts.remove(event.removeProduct);
    emit(WishlistLoadedState(wishlistProducts: wishlistedProducts));
    emit(RemovedProductFromWishlistState());
  }
}

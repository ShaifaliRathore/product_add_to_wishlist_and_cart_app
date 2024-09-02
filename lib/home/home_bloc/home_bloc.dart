import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wishlist_cart_product/data/cart_products.dart';
import 'package:wishlist_cart_product/data/products.dart';
import 'package:wishlist_cart_product/data/wishlist_products.dart';
import 'package:wishlist_cart_product/home/home_bloc/home_event.dart';
import 'package:wishlist_cart_product/home/home_bloc/home_state.dart';
import 'package:wishlist_cart_product/model/product_model.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<NavigateToWishlistPageEvent>(navigateToWishlistPageEvent);
    on<NavigateToCartPageEvent>(navigateToCartPageEvent);
    on<ProductAddToWishlistEvent>(productWishlistEvent);
    on<ProductAddToCartEvent>(productAddToCartEvent);
  }

  Future<FutureOr<void>> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());
    await Future.delayed(const Duration(seconds: 3));
    emit(HomeLoadedState(
        products: ProductData.productList
            .map((e) => ProductDataModel(
                id: e['id'],
                name: e['name'],
                price: e['price'],
                quantity: e['quantity'],
                category: e['category'],
                isAvailable: e['isAvailable'],
                image: e['image']))
            .toList()));
  }

  FutureOr<void> navigateToWishlistPageEvent(
      NavigateToWishlistPageEvent event, Emitter<HomeState> emit) {
    log("NavigateToWishlistPageEvent added");
    emit(HomeNavigateToWishlistPageState());
  }

  FutureOr<void> navigateToCartPageEvent(
      NavigateToCartPageEvent event, Emitter<HomeState> emit) {
    log("NavigateToCartPageEvent added");
    emit(HomeNavigateToCartPageState());
  }

  FutureOr<void> productWishlistEvent(
      ProductAddToWishlistEvent event, Emitter<HomeState> emit) {
    log("ProductWishlistEvent added");
    if (wishlistedProducts
            .indexWhere((e) => e.id == event.wishlistProduct.id) ==
        -1) {
      wishlistedProducts.add(event.wishlistProduct);
      emit(ProductAddedToWishlistState());
    } else {
      wishlistedProducts.remove(event.wishlistProduct);
      emit(ProductRemovedFromWishlistState());
    }
  }

  FutureOr<void> productAddToCartEvent(
      ProductAddToCartEvent event, Emitter<HomeState> emit) {
    log("ProductAddToCartEvent added");
    cartProdcuts.add(event.cartProduct);
    emit(ProductAddedToCartState());
  }
}

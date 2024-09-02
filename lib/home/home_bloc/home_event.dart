import 'package:wishlist_cart_product/model/product_model.dart';

abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class NavigateToWishlistPageEvent extends HomeEvent {}

class NavigateToCartPageEvent extends HomeEvent {}

class ProductAddToWishlistEvent extends HomeEvent {
  final ProductDataModel wishlistProduct;

  ProductAddToWishlistEvent({required this.wishlistProduct});
}

class ProductAddToCartEvent extends HomeEvent {
  final ProductDataModel cartProduct;

  ProductAddToCartEvent({required this.cartProduct});
}

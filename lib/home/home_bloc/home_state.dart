import 'package:wishlist_cart_product/model/product_model.dart';

abstract class HomeState {}

abstract class HomeActionState extends HomeState {}

class HomeInitialState extends HomeState {}

class HomeNavigateToWishlistPageState extends HomeActionState {}

class HomeNavigateToCartPageState extends HomeActionState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final List<ProductDataModel> products;

  HomeLoadedState({required this.products});
}

class HomeErrorState extends HomeState {}

class ProductAddedToWishlistState extends HomeActionState {}

class ProductRemovedFromWishlistState extends HomeActionState {}

class ProductAddedToCartState extends HomeActionState {}

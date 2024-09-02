import 'package:wishlist_cart_product/model/product_model.dart';

abstract class CartState {}

abstract class CartActionState extends CartState {}

final class CartInitialState extends CartState {}

final class CartLoadedState extends CartState {
  final List<ProductDataModel> cartProducts;

  CartLoadedState({required this.cartProducts});
}

final class RemovedProdcutFromCartState extends CartActionState {}

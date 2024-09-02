import 'package:wishlist_cart_product/model/product_model.dart';

abstract class CartEvent {}

class CartInitialEvent extends CartEvent {}

class RemoveProductFromCartEvent extends CartEvent {
  final ProductDataModel removeProduct;

  RemoveProductFromCartEvent({required this.removeProduct});
}

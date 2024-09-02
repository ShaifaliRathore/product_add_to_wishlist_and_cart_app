import 'package:wishlist_cart_product/model/product_model.dart';

abstract class WishlistEvent {}

final class WishlistInitialEvent extends WishlistEvent {}

final class RemoveProductFromWishlistEvent extends WishlistEvent {
  final ProductDataModel removeProduct;

  RemoveProductFromWishlistEvent({required this.removeProduct});
}

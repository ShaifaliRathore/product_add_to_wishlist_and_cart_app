import 'package:wishlist_cart_product/model/product_model.dart';

abstract class WishlistState {}

abstract class WishlistActionState extends WishlistState {}

final class WishlistInitialState extends WishlistState {}

final class WishlistLoadedState extends WishlistState {
  final List<ProductDataModel> wishlistProducts;

  WishlistLoadedState({required this.wishlistProducts});
}

class RemovedProductFromWishlistState extends WishlistActionState {}

import 'package:flutter/material.dart';
import 'package:wishlist_cart_product/model/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductDataModel productModel;
  VoidCallback? onWishlistPressed;
  VoidCallback? onAddToCartPressed;
  VoidCallback? onRemoveFromCartPressed;
  VoidCallback? onRemoveFromWishlistPressed;
  ProductCard(
      {super.key,
      required this.productModel,
      this.onWishlistPressed,
      this.onAddToCartPressed,
      this.onRemoveFromCartPressed,
      this.onRemoveFromWishlistPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[300],
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 200,
              width: double.maxFinite,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  productModel.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              productModel.name,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              productModel.category,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${productModel.price}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onWishlistPressed != null && onAddToCartPressed != null
                    ? Row(
                        children: [
                          IconButton(
                            onPressed: () => onWishlistPressed!(),
                            icon: const Icon(Icons.favorite_outline),
                          ),
                          IconButton(
                            onPressed: () => onAddToCartPressed!(),
                            icon: const Icon(Icons.shopping_bag_outlined),
                          ),
                        ],
                      )
                    : onRemoveFromCartPressed != null
                        ? IconButton(
                            onPressed: () => onRemoveFromCartPressed!(),
                            icon: const Icon(Icons.clear),
                          )
                        : onRemoveFromWishlistPressed != null
                            ? IconButton(
                                onPressed: () => onRemoveFromWishlistPressed!(),
                                icon: const Icon(Icons.delete_outline),
                              )
                            : const SizedBox.shrink()
              ],
            )
          ],
        ),
      ),
    );
  }
}

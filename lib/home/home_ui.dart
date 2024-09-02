import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wishlist_cart_product/cart/cart_ui.dart';
import 'package:wishlist_cart_product/component/product_card.dart';
import 'package:wishlist_cart_product/home/home_bloc/home_bloc.dart';
import 'package:wishlist_cart_product/home/home_bloc/home_event.dart';
import 'package:wishlist_cart_product/home/home_bloc/home_state.dart';
import 'package:wishlist_cart_product/wishlist/wishlist_ui.dart';

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final HomeBloc _homeBloc = HomeBloc();

  @override
  void initState() {
    _homeBloc.add(HomeInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: _homeBloc,
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, state) {
        if (state is HomeNavigateToWishlistPageState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const WishlistPage(),
            ),
          );
        }

        if (state is HomeNavigateToCartPageState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CartPage(),
            ),
          );
        }

        if (state is ProductAddedToWishlistState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Row(
                children: [
                  Text(
                    'Product successfully added to ',
                  ),
                  Icon(
                    Icons.favorite_outline,
                    color: Colors.white,
                  )
                ],
              ),
              duration: Duration(seconds: 1),
            ),
          );
        }

        if (state is ProductAddedToCartState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.green,
              content: Row(
                children: [
                  Text(
                    'Product successfully added to ',
                  ),
                  Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.white,
                  )
                ],
              ),
              duration: Duration(seconds: 1),
            ),
          );
        }

        if (state is ProductRemovedFromWishlistState) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Row(
                children: [
                  Text(
                    'Product removed successfully from ',
                  ),
                  Icon(
                    Icons.favorite_outlined,
                    color: Colors.white,
                  )
                ],
              ),
              duration: Duration(seconds: 1),
            ),
          );
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case HomeLoadingState:
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );

          case HomeLoadedState:
            final successState = state as HomeLoadedState;
            return Scaffold(
              appBar: AppBar(
                title: const Text('Products'),
                actions: [
                  IconButton(
                    onPressed: () =>
                        _homeBloc.add(NavigateToWishlistPageEvent()),
                    icon: const Icon(Icons.favorite_outline),
                  ),
                  IconButton(
                    onPressed: () => _homeBloc.add(NavigateToCartPageEvent()),
                    icon: const Icon(Icons.shopping_bag_outlined),
                  )
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: successState.products.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ProductCard(
                            productModel: successState.products[index],
                            onWishlistPressed: () => _homeBloc.add(
                              ProductAddToWishlistEvent(
                                  wishlistProduct:
                                      successState.products[index]),
                            ),
                            onAddToCartPressed: () => _homeBloc.add(
                              ProductAddToCartEvent(
                                  cartProduct: successState.products[index]),
                            ),
                          ),
                          const SizedBox(
                            height: 5.0,
                          )
                        ],
                      );
                    }),
              ),
            );

          case HomeErrorState:
            return const Scaffold(
              body: Center(child: Text("Error loading prodcuts")),
            );

          default:
            return Container();
        }
      },
    );
  }
}

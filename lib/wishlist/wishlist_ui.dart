import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wishlist_cart_product/component/product_card.dart';
import 'package:wishlist_cart_product/wishlist/bloc/wishlist_bloc.dart';
import 'package:wishlist_cart_product/wishlist/bloc/wishlist_event.dart';
import 'package:wishlist_cart_product/wishlist/bloc/wishlist_state.dart';

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final WishlistBloc _wishlistBloc = WishlistBloc();

  @override
  void initState() {
    _wishlistBloc.add(WishlistInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Row(
            children: [
              Icon(Icons.favorite_outline),
              SizedBox(
                width: 5.0,
              ),
              Text('Wishlist'),
            ],
          ),
        ),
        body: BlocConsumer<WishlistBloc, WishlistState>(
          bloc: _wishlistBloc,
          listenWhen: (previous, current) => current is WishlistActionState,
          buildWhen: (previous, current) => current is! WishlistActionState,
          listener: (context, state) {
            if (state is RemovedProductFromWishlistState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.green,
                  content: Row(
                    children: [
                      Text(
                        'Product removed successfully from ',
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
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case WishlistLoadedState:
                final wishlistState = state as WishlistLoadedState;
                return wishlistState.wishlistProducts.isEmpty
                    ? const Center(
                        child: Text('Wishlist is empty'),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                            itemCount: wishlistState.wishlistProducts.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  ProductCard(
                                    productModel:
                                        wishlistState.wishlistProducts[index],
                                    onRemoveFromWishlistPressed: () =>
                                        _wishlistBloc.add(
                                      RemoveProductFromWishlistEvent(
                                          removeProduct: wishlistState
                                              .wishlistProducts[index]),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5.0,
                                  )
                                ],
                              );
                            }),
                      );

              default:
                return const SizedBox.shrink();
            }
          },
        ));
  }
}

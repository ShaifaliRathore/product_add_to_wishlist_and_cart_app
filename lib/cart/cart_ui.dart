import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wishlist_cart_product/cart/bloc/cart_bloc.dart';
import 'package:wishlist_cart_product/cart/bloc/cart_event.dart';
import 'package:wishlist_cart_product/cart/bloc/cart_state.dart';
import 'package:wishlist_cart_product/component/product_card.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final CartBloc _cartBloc = CartBloc();

  @override
  void initState() {
    _cartBloc.add(CartInitialEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Row(
            children: [
              Icon(Icons.shopping_bag_outlined),
              SizedBox(
                width: 5.0,
              ),
              Text('Cart'),
            ],
          ),
        ),
        body: BlocConsumer<CartBloc, CartState>(
          bloc: _cartBloc,
          listenWhen: (previous, current) => current is CartActionState,
          buildWhen: (previous, current) => current is! CartActionState,
          listener: (context, state) {
            if (state is RemovedProdcutFromCartState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  backgroundColor: Colors.green,
                  content: Row(
                    children: [
                      Text(
                        'Product removed successfully from ',
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
          },
          builder: (context, state) {
            switch (state.runtimeType) {
              case CartLoadedState:
                final cartState = state as CartLoadedState;
                return cartState.cartProducts.isEmpty
                    ? const Center(
                        child: Text('Cart is empty'),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                            itemCount: cartState.cartProducts.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  ProductCard(
                                    productModel: cartState.cartProducts[index],
                                    onRemoveFromCartPressed: () =>
                                        _cartBloc.add(
                                      RemoveProductFromCartEvent(
                                          removeProduct:
                                              cartState.cartProducts[index]),
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wishlist_cart_product/home/home_bloc/home_bloc.dart';
import 'package:wishlist_cart_product/home/home_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
        useMaterial3: false,
      ),
      home: BlocProvider(
        create: (context) => HomeBloc(),
        child: const ProductListPage(),
      ),
    );
  }
}

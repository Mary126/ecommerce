import 'package:ecommerce/pages/cart_screen.dart';
import 'package:ecommerce/pages/product_screen.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/pages/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ECommerce',
      routes: {
        '/': (context) => const MainScreen(),
        '/product_screen': (context) => const ProductScreen(),
        '/cart_screen': (context) => const CartScreen()
      },
      initialRoute: '/',
    );
  }
}

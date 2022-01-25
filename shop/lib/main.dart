import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/cart_detail.dart';
import './screens/product_detail.dart';
import './screens/product_overview.dart';
import './screens/orders.dart';
import './screens/user_products.dart';
import './screens/edit_product.dart';
import './providers/products.dart';
import './providers/cart.dart';
import './providers/orders.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Products(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (_) => Orders(),
        ),
      ],
      child: MaterialApp(
        title: 'Shop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        routes: {
          '/': (ctx) => ProductOverview(),
          ProductDetail.routeName: (ctx) => ProductDetail(),
          CartDetail.routeName: (ctx) => CartDetail(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
          UserProducts.routeName: (ctx) => UserProducts(),
          EditProduct.routeName: (ctx) => EditProduct(),
        },
      ),
    );
  }
}

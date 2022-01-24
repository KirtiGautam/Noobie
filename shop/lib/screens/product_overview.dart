import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../screens/cart_detail.dart';
import '../widgets/badge.dart';
import '../widgets/products_grid.dart';
import '../widgets/app_drawer.dart';

enum FavoriteFilterOption {
  all,
  favorites,
}

class ProductOverview extends StatefulWidget {
  @override
  State<ProductOverview> createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  var _showFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop'),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(
                child: Text('Only Favorites'),
                value: FavoriteFilterOption.favorites,
              ),
              const PopupMenuItem(
                child: Text('All Items'),
                value: FavoriteFilterOption.all,
              ),
            ],
            onSelected: (FavoriteFilterOption val) => setState(
                () => _showFavorites = (val == FavoriteFilterOption.favorites)),
          ),
          Consumer<Cart>(
            builder: (_, cart, child) => Badge(
              child: child,
              value: cart.count.toString(),
            ),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () => Navigator.of(context).pushNamed(
                CartDetail.routeName,
              ),
            ),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: ProductsGrid(_showFavorites),
    );
  }
}

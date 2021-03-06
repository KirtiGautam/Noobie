import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/auth.dart';

import '../providers/cart.dart';
import '../providers/product.dart';
import '../screens/product_detail.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context);
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    return GridTile(
      child: GestureDetector(
        onTap: () => Navigator.of(context).pushNamed(
          ProductDetail.routeName,
          arguments: product.id,
        ),
        child: Image.network(
          product.imageURL,
          fit: BoxFit.cover,
        ),
      ),
      footer: GridTileBar(
        backgroundColor: Colors.black87,
        leading: IconButton(
          icon: Icon(
            product.isFavorite ? Icons.favorite : Icons.favorite_border,
          ),
          color: Theme.of(context).accentColor,
          onPressed: () => product.toggleFavorite(
            authData.token!,
            authData.userID!,
          ),
        ),
        title: Text(
          product.title,
          textAlign: TextAlign.center,
        ),
        trailing: IconButton(
          icon: const Icon(Icons.shopping_cart),
          color: Theme.of(context).accentColor,
          onPressed: () {
            cart.addItem(
              product.id,
              product.title,
              product.price,
            );
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Item added successfully'),
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () => cart.removeSingleItem(product.id),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

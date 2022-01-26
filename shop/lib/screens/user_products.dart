import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../screens/edit_product.dart';
import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';

class UserProducts extends StatelessWidget {
  static const routeName = '/user-products';

  Future<void> refreshProducts(BuildContext context) => Provider.of<Products>(
        context,
        listen: false,
      ).fetchAndSetProducts();

  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    return RefreshIndicator(
      onRefresh: () => refreshProducts(context),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Your Products'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => Navigator.of(context).pushNamed(
                EditProduct.routeName,
              ),
            ),
          ],
        ),
        drawer: AppDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: productsData.items.length,
            itemBuilder: (_, i) => UserProductItem(
              productsData.items[i].id,
              productsData.items[i].title,
              productsData.items[i].imageURL,
            ),
          ),
        ),
      ),
    );
  }
}

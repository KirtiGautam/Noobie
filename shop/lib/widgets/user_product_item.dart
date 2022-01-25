import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../screens/edit_product.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageURL;

  UserProductItem(this.id, this.title, this.imageURL);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(imageURL),
        ),
        title: Text(title),
        trailing: Container(
          width: 100,
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                color: Theme.of(context).primaryColor,
                onPressed: () => Navigator.of(context).pushNamed(
                  EditProduct.routeName,
                  arguments: id,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => Provider.of<Products>(
                  context,
                  listen: false,
                ).deleteProduct(id),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

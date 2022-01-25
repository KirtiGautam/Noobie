import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartItem extends StatelessWidget {
  final String id;
  final String productID;
  final String title;
  final int quantity;
  final double price;

  CartItem(this.id, this.productID, this.title, this.quantity, this.price);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Theme.of(context).errorColor,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 8,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
      ),
      confirmDismiss: (_) => showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text('Do you want to remove item from cart?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text('Yes'),
            ),
          ],
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 8,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: FittedBox(child: Text('₹$price')),
              ),
            ),
            title: Text(title),
            subtitle: Text('Total: ₹${price * quantity}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
      onDismissed: (_) => Provider.of<Cart>(
        context,
        listen: false,
      ).removeItem(productID),
    );
  }
}

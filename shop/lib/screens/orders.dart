import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Orders>(
          context,
          listen: false,
        ).fetchAndSetProducts(),
        builder: (ctx, data) =>
            (data.connectionState == ConnectionState.waiting)
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : (data.error != null
                    ? const Center(
                        child: Text('Some error occurred'),
                      )
                    : Consumer<Orders>(
                        builder: (ctx, orders, child) => ListView.builder(
                          itemCount: orders.orders.length,
                          itemBuilder: (_, index) => OrderItem(
                            orders.orders[index],
                          ),
                        ),
                      )),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../env.dart';
import '../providers/cart.dart' show CartItem;

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;
  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  final String? authToken;
  final String? userID;
  Orders(this.authToken, this.userID, this._orders);
  List<OrderItem> get orders => [..._orders];

  Future<void> fetchAndSetProducts() {
    final uri = Uri.parse(
      '$URL/orders/$userID.json?auth=$authToken',
    );
    return http.get(uri).then((resp) {
      final data = json.decode(resp.body) as Map<String, dynamic>;
      final List<OrderItem> orderItems = [];
      data.forEach((key, value) {
        orderItems.add(OrderItem(
          id: key,
          amount: value['amount'],
          dateTime: DateTime.parse(value['dateTime']),
          products: (value['products'] as List<dynamic>)
              .map((e) => CartItem(
                    id: e['id'],
                    title: e['title'],
                    quantity: e['quantity'] as int,
                    price: e['price'],
                  ))
              .toList(),
        ));
      });
      _orders = orderItems;
      notifyListeners();
    });
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) {
    final uri = Uri.parse(
      '$URL/orders/$userID.json?auth=$authToken',
    );
    final timestamp = DateTime.now();
    return http
        .post(
      uri,
      body: json.encode(
        {
          'amount': total,
          'dateTime': timestamp.toIso8601String(),
          'products': cartProducts
              .map((e) => {
                    'id': e.id,
                    'title': e.title,
                    'quantity': e.quantity,
                    'price': e.price,
                  })
              .toList(),
        },
      ),
    )
        .then((value) {
      _orders.insert(
        0,
        OrderItem(
          id: json.decode(value.body)['name'],
          amount: total,
          dateTime: timestamp,
          products: cartProducts,
        ),
      );
      notifyListeners();
    });
  }
}

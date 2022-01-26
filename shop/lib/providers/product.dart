import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../env.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final String imageURL;
  final double price;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.imageURL,
    required this.price,
    this.isFavorite = false,
  });

  Future<void> toggleFavorite() {
    final uri = Uri.parse(
      '$URL/products/$id.json',
    );

    isFavorite = !isFavorite;
    notifyListeners();
    return http.patch(
      uri,
      body: json.encode(
        {
          'isFavorite': isFavorite,
        },
      ),
    );
  }
}

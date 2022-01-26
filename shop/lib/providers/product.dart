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

  Future<void> toggleFavorite(String authToken, String userID) {
    final uri = Uri.parse(
      '$URL/userFavorites/$userID/$id.json?auth=$authToken',
    );

    isFavorite = !isFavorite;
    notifyListeners();
    return http.put(
      uri,
      body: json.encode(isFavorite),
    );
  }
}

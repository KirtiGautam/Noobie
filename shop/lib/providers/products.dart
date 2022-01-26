import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../env.dart';
import './product.dart';

class Products with ChangeNotifier {
  final uri = '$URL/products';
  List<Product> _products = [];

  List<Product> get items => [..._products];
  List<Product> get favoriteItems =>
      _products.where((product) => product.isFavorite).toList();

  Product findById(String id) =>
      _products.firstWhere((product) => product.id == id);

  Future<void> fetchAndSetProducts() {
    return http.get(Uri.parse('$uri.json')).then((resp) {
      final data = json.decode(resp.body) as Map<String, dynamic>;
      final List<Product> loadedProducts = [];
      data.forEach((key, value) {
        loadedProducts.add(Product(
          id: key,
          title: value['title'],
          description: value['description'],
          imageURL: value['imageURL'],
          price: value['price'],
          isFavorite: value['isFavorite'],
        ));
      });
      _products = loadedProducts;
      notifyListeners();
    });
  }

  Future<void> addProduct(Product prod) {
    return http
        .post(
      Uri.parse('$uri.json'),
      body: json.encode(
        {
          'title': prod.title,
          'description': prod.description,
          'imageURL': prod.imageURL,
          'price': prod.price,
          'isFavorite': prod.isFavorite,
        },
      ),
    )
        .then((value) {
      final product = Product(
        id: json.decode(value.body)['name'],
        title: prod.title,
        description: prod.description,
        imageURL: prod.imageURL,
        price: prod.price,
      );
      _products.add(product);
      notifyListeners();
    });
  }

  Future<void> editProduct(Product prod) {
    final prodIndex = _products.indexWhere((element) => prod.id == element.id);
    if (prodIndex >= 0) {
      return http
          .patch(
        Uri.parse(
          '$uri/${prod.id}.json',
        ),
        body: json.encode(
          {
            'title': prod.title,
            'description': prod.description,
            'imageURL': prod.imageURL,
            'price': prod.price,
          },
        ),
      )
          .then((value) {
        _products[prodIndex] = prod;
        notifyListeners();
      });
    }
    return Future<void>(() {});
  }

  Future<void> deleteProduct(String id) {
    return http
        .delete(
      Uri.parse(
        '$uri/$id.json',
      ),
    )
        .then((value) {
      _products.removeWhere((element) => element.id == id);
      notifyListeners();
    });
  }
}

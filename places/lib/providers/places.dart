import 'dart:io';

import 'package:flutter/material.dart';

import '../models/place.dart';

class Places with ChangeNotifier {
  List<Place> _places = [];

  List<Place> get places => [..._places];

  void addPlace(String title, File? image) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      image: image!,
      location: null,
    );
    _places.add(newPlace);
    notifyListeners();
  }
}

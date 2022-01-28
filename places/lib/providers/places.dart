import 'dart:io';

import 'package:flutter/material.dart';

import '../helpers/db_helper.dart';
import '../models/place.dart';

class Places with ChangeNotifier {
  List<Place> _places = [];

  List<Place> get places => [..._places];

  Future<void> fetchAndSetPlaces() =>
      DBHelper.getData('places').then((dataList) {
        _places = dataList
            .map((e) => Place(
                  id: e['id'],
                  title: e['title'],
                  image: File(e['image']),
                  location: Location(
                    latitude: e['loc_lat'],
                    longitude: e['loc_long'],
                    address: e['address'],
                  ),
                ))
            .toList();
        notifyListeners();
      });

  void addPlace(String title, File? image, Location? loc) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      title: title,
      image: image!,
      location: loc,
    );
    _places.add(newPlace);
    notifyListeners();
    DBHelper.insert(
      'places',
      {
        'id': newPlace.id,
        'title': newPlace.title,
        'image': image.path,
        'loc_lat': newPlace.location!.latitude,
        'loc_long': newPlace.location!.latitude,
        'address': newPlace.location!.latitude,
      },
    );
  }
}

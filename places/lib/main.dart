import 'package:flutter/material.dart';
import 'package:places/providers/places.dart';
import 'package:places/screens/add_place.dart';
import 'package:provider/provider.dart';

import '../screens/places_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: Places(),
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        home: PlacesList(),
        routes: {
          AddPlace.routeName: (_) => AddPlace(),
        },
      ),
    );
  }
}

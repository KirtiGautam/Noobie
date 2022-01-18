import 'package:flutter/material.dart';

import './screens/filters.dart';
import './screens/meal.dart';
import './screens/tabs.dart';
import './screens/meals.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final ThemeData theme = ThemeData(primarySwatch: Colors.pink);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Meals',
        theme: theme.copyWith(
          canvasColor: const Color.fromRGBO(255, 254, 229, 1),
          colorScheme: theme.colorScheme.copyWith(
            secondary: Colors.amber,
            primary: Colors.pink,
          ),
        ),
        routes: {
          '/': (ctx) => Tabs(),
          '/filter': (ctx) => Filter(),
          '/meals': (ctx) => Meals(),
          '/meal': (ctx) => MealItemScreen(),
        });
  }
}

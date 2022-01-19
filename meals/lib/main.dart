import 'package:flutter/material.dart';

import './dummy_data.dart';
import './models/meal.dart';
import './screens/filters.dart';
import './screens/meal.dart';
import './screens/tabs.dart';
import './screens/meals.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeData theme = ThemeData(primarySwatch: Colors.pink);

  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> _meals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void toggleFavorite(mealId) {
    var index = _favoriteMeals.indexWhere((meal) => meal.id == mealId);
    setState(() => (index >= 0)
        ? _favoriteMeals.removeAt(index)
        : _favoriteMeals
            .add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealId)));
  }

  void isFavorite(mealId) => _favoriteMeals.any((meal) => meal.id == mealId);

  void _saveFilters(Map<String, bool> filterData) =>
      setState(() => _meals = DUMMY_MEALS.where((meal) {
            _filters = filterData;
            if (_filters['gluten']! && !meal.isGlutenFree) {
              return false;
            }
            if (_filters['lactose']! && !meal.isLactoseFree) {
              return false;
            }
            if (_filters['vegan']! && !meal.isVegan) {
              return false;
            }
            if (_filters['vegetarian']! && !meal.isVegetarian) {
              return false;
            }
            return true;
          }).toList());

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
          '/': (ctx) => Tabs(_favoriteMeals),
          '/filter': (ctx) => Filter(_filters, _saveFilters),
          '/meals': (ctx) => Meals(_meals),
          '/meal': (ctx) => MealItemScreen(toggleFavorite, isFavorite)
        });
  }
}

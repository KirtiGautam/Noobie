import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';

import '../widgets/meals_item.dart';
import '../dummy_data.dart';

class Meals extends StatefulWidget {
  final List<Meal> _meals;

  Meals(this._meals);

  @override
  State<Meals> createState() => _MealsState();
}

class _MealsState extends State<Meals> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final title = args['title']!;
    final meals = widget._meals
        .where(
          (e) => e.categories.contains(args['id']),
        )
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) => MealItem(
          meals[index].id,
          meals[index].imageURL,
          meals[index].title,
          meals[index].duration,
          meals[index].complexity,
          meals[index].affordability,
        ),
        itemCount: meals.length,
      ),
    );
  }
}

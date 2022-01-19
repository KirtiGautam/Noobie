import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meals_item.dart';

class Favorites extends StatelessWidget {
  final List<Meal> meals;
  Favorites(this.meals);

  @override
  Widget build(BuildContext context) => meals.isEmpty
      ? const Center(
          child: Text('No Favorite Meals, add some!'),
        )
      : ListView.builder(
          itemBuilder: (ctx, index) => MealItem(
            meals[index].id,
            meals[index].imageURL,
            meals[index].title,
            meals[index].duration,
            meals[index].complexity,
            meals[index].affordability,
          ),
          itemCount: meals.length,
        );
}

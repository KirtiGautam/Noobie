import 'package:flutter/material.dart';
import 'package:meals/dummy_data.dart';
import 'package:meals/models/meal.dart';

class MealItemScreen extends StatelessWidget {
  Widget buildTitle(String text) => Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      );

  Widget buildContainer(Widget child) => Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        height: 200,
        width: 400,
        child: child,
      );

  @override
  Widget build(BuildContext context) {
    final Meal meal = DUMMY_MEALS.firstWhere(
      (element) =>
          element.id ==
          (ModalRoute.of(context)!.settings.arguments
              as Map<String, String>)['id']!,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 400,
              width: double.infinity,
              child: Image.network(
                meal.imageURL,
                fit: BoxFit.cover,
              ),
            ),
            buildTitle('Ingredients'),
            buildContainer(
              ListView.builder(
                itemBuilder: (ctx, index) => Card(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    child: Text(meal.ingredients[index]),
                  ),
                  color: Theme.of(context).colorScheme.secondary,
                ),
                itemCount: meal.ingredients.length,
              ),
            ),
            buildTitle('Steps'),
            buildContainer(ListView.builder(
              itemBuilder: (ctx, index) => Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      child: Text('# ${(index + 1)}'),
                    ),
                    title: Text(
                      meal.steps[index],
                    ),
                  ),
                  const Divider(),
                ],
              ),
              itemCount: meal.steps.length,
            ))
          ],
        ),
      ),
    );
  }
}

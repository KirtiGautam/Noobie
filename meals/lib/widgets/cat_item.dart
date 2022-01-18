import 'package:flutter/material.dart';

class CatItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  CatItem(this.id, this.title, this.color);

  void loadMeals(BuildContext ctx) =>
      Navigator.of(ctx).pushNamed('/meals', arguments: {
        'id': id,
        'title': title,
      });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => loadMeals(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        child: Text(title),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.7),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';

import '../widgets/main_drawer.dart';
import './categories.dart';
import './favorites.dart';

class Tabs extends StatelessWidget {
  final List<Meal> favorites;
  Tabs(this.favorites);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Meals App'),
          bottom: const TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.category),
                text: 'Categories',
              ),
              Tab(
                icon: Icon(Icons.star),
                text: 'Favorites',
              )
            ],
          ),
        ),
        drawer: MainDrawer(),
        body: TabBarView(
          children: [
            Categories(),
            Favorites(favorites),
          ],
        ),
      ),
    );
  }
}

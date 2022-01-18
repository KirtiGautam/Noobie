import 'package:flutter/material.dart';

import '../dummy_data.dart';
import '../widgets/cat_item.dart';

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView(
      children:
          DUMMY_CATEGORIES.map((e) => CatItem(e.id, e.title, e.color)).toList(),
      padding: const EdgeInsets.all(15),
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
    );
  }
}

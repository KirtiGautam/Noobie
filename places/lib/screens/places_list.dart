import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/places.dart';
import '../screens/add_place.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Your Places'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => Navigator.of(context).pushNamed(
                AddPlace.routeName,
              ),
            ),
          ],
        ),
        body: Consumer<Places>(
          child: const Center(
            child: Text('No places to show'),
          ),
          builder: (ctx, places, child) => (places.places.isEmpty)
              ? child!
              : ListView.builder(
                  itemCount: places.places.length,
                  itemBuilder: (ct, i) => ListTile(
                    leading: CircleAvatar(
                      backgroundImage: FileImage(
                        places.places[i].image,
                      ),
                    ),
                    title: Text(places.places[i].title),
                    onTap: () {},
                  ),
                ),
        ),
      );
}

import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class Filter extends StatefulWidget {
  final Map<String, bool> _currentFilters;
  final Function _saveFilters;

  Filter(this._currentFilters, this._saveFilters);

  @override
  State<Filter> createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  var _glutenFree = false;
  var _lactoseFree = false;
  var _isVegan = false;
  var _isVegetarian = false;

  @override
  initState() {
    _glutenFree = widget._currentFilters['gluten'] ?? _glutenFree;
    _lactoseFree = widget._currentFilters['latose'] ?? _lactoseFree;
    _isVegan = widget._currentFilters['vegan'] ?? _isVegan;
    _isVegetarian = widget._currentFilters['vegetarian'] ?? _isVegetarian;
    super.initState();
  }

  Widget _buildListSwitch(
    String title,
    String description,
    bool currentValue,
    Function(bool) updateValue,
  ) =>
      SwitchListTile(
        title: Text(title),
        subtitle: Text(description),
        value: currentValue,
        onChanged: updateValue,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your filters'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () => widget._saveFilters({
              'gluten': _glutenFree,
              'lactose': _lactoseFree,
              'vegan': _isVegan,
              'vegetarian': _isVegetarian,
            }),
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: const Text('Adjust your meal selection'),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildListSwitch(
                  'Gluten-free',
                  'Only include gluten-free meals',
                  _glutenFree,
                  (newVal) => setState(
                    () => _glutenFree = newVal,
                  ),
                ),
                _buildListSwitch(
                  'Lactose-free',
                  'Only include lactose-free meals',
                  _lactoseFree,
                  (newVal) => setState(
                    () => _lactoseFree = newVal,
                  ),
                ),
                _buildListSwitch(
                  'Vegetarian',
                  'Only include vegetarian meals',
                  _isVegetarian,
                  (newVal) => setState(
                    () => _isVegetarian = newVal,
                  ),
                ),
                _buildListSwitch(
                  'Vegan',
                  'Only include vegan meals',
                  _isVegan,
                  (newVal) => setState(
                    () => _isVegan = newVal,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class Filter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your filters'),
      ),
      drawer: MainDrawer(),
      body: const Center(
        child: Text('SD'),
      ),
    );
  }
}

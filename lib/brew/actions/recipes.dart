import 'package:flutter/material.dart';

class ActionRecipes extends StatelessWidget {
  const ActionRecipes({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.folder_special),
      onPressed: () {
        Scaffold.of(context).openDrawer();
      },
    );
  }
}

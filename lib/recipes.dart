import 'package:brew/models/book.dart';
import 'package:flutter/material.dart';

class Recipes extends StatelessWidget {
  final Book book;
  final Function(String name) onLoad;
  final Function(String name) onRemove;
  const Recipes({super.key, required this.book, required this.onLoad, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: book
            .map(
              (recipe) => ListTile(
                title: Text(recipe),
                onTap: () {
                  onLoad(recipe);
                  Navigator.pop(context);
                },
                onLongPress: () {
                  onRemove(recipe);
                  Navigator.pop(context);
                },
              ),
            )
            .toList(),
      ),
    );
  }
}

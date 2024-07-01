import 'package:brew/helpers/size.dart';
import 'package:brew/models/recipe.dart';
import 'package:brew/models/book.dart';
import 'package:brew/recipes.dart';
import 'package:brew/save.dart';
import 'package:brew/widgets/dial/decimal.dart';
import 'package:brew/widgets/dial/ratio.dart';
import 'package:flutter/material.dart';

class BrewPage extends StatefulWidget {
  const BrewPage({super.key});
  @override
  State<BrewPage> createState() => _BrewPageState();
}

class _BrewPageState extends State<BrewPage> {
  Book book = bookOpen();
  Recipe recipe = Recipe.load();

  @override
  Widget build(BuildContext context) {
    relativeSize.update(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: book.isNotEmpty,
        backgroundColor: Colors.brown.shade900,
        title: const Text('Brew'),
        actions: [
          Save(
            onSave: (name) async {
              debugPrint('Save recipe $name');
              await bookSaveRecipe(name, recipe);
              setState(() {
                book = bookOpen();
              });
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            DialRatio(
              name: 'Coffee to water ratio',
              value1: recipe.coffeeRatio,
              value2: recipe.waterRatio,
              color1: Colors.brown.withOpacity(0.2),
              color2: Colors.blue.withOpacity(0.2),
              onChanged1: (value) {
                setState(() {
                  recipe.coffeeRatio = value;
                });
              },
              onChanged2: (value) {
                setState(() {
                  recipe.waterRatio = value;
                });
              },
            ),
            DialDecimal(
              name: 'Coffee amount',
              color: Colors.brown.withOpacity(0.4),
              min: 1.0,
              max: 100.0,
              value: recipe.coffeeAmount,
              onChanged: (value) {
                setState(() {
                  recipe.coffeeAmount = value;
                });
              },
            ),
            DialDecimal(
              name: 'Water amount',
              color: Colors.blue.withOpacity(0.4),
              min: 1.0,
              max: 1000.0,
              value: recipe.waterAmount,
              onChanged: (value) {
                setState(() {
                  recipe.waterAmount = value;
                });
              },
            ),
          ],
        ),
      ),
      drawer: Recipes(
        book: book,
        onLoad: (name) {
          debugPrint('Load recipe $name');
          setState(() {
            Recipe? temp = bookLoadRecipe(name);
            if (temp == null) return;
            recipe = temp;
            recipe.save();
          });
        },
        onRemove: (name) async {
          debugPrint('Remove recipe $name');
          await bookRemoveRecipe(name);
          setState(() {
            book = bookOpen();
          });
        },
      ),
    );
  }
}

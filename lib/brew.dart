import 'package:brew/brew/actions/notes.dart';
import 'package:brew/brew/recipes.dart';
import 'package:brew/size.dart';
import 'package:brew/models/recipe.dart';
import 'package:brew/models/book.dart';
import 'package:brew/brew/actions/recipes.dart';
import 'package:brew/brew/actions/save.dart';
import 'package:brew/brew/dial/decimal.dart';
import 'package:brew/brew/dial/ratio.dart';
import 'package:brew/theme/colors.dart';
import 'package:flutter/material.dart';

class BrewPage extends StatefulWidget {
  const BrewPage({super.key});
  @override
  State<BrewPage> createState() => _BrewPageState();
}

class _BrewPageState extends State<BrewPage> with TickerProviderStateMixin {
  Book book = bookOpen();
  Recipe recipe = Recipe.load();

  onLoad(String name) {
    debugPrint('Load recipe $name');
    Recipe? recipeNew = bookLoadRecipe(name);
    if (recipeNew == null) return;
    recipeNew.save();
    setState(() => recipe = recipeNew);
  }

  onRemove(String name) async {
    debugPrint('Remove recipe $name');
    await bookRemoveRecipe(name);
    setState(() => book = bookOpen());
  }

  @override
  Widget build(BuildContext context) {
    relativeSize.update(context);
    return Scaffold(
      appBar: AppBar(
        leading: book.isEmpty ? null : const ActionRecipes(),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.brown.shade900,
        title: const Text('Brew'),
        actions: [
          ActionNotes(
            notes: recipe.notes,
            onSave: (notes) {
              Recipe recipeNew = recipe.clone();
              recipeNew.notes = notes;
              recipeNew.save();
              setState(() => recipe = recipeNew);
            },
          ),
          const SizedBox(width: 12.0),
          ActionSave(
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
      drawer: DrawerRecipes(
        book: book,
        onLoad: onLoad,
        onRemove: onRemove,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          DialRatio(
            name: 'Coffee to water ratio',
            value1: recipe.coffeeRatio,
            value2: recipe.waterRatio,
            color1: colorCoffeeWeak,
            color2: colorWaterWeak,
            onChanged1: (value) {
              setState(() => recipe.coffeeRatio = value);
            },
            onChanged2: (value) {
              setState(() => recipe.waterRatio = value);
            },
          ),
          DialDecimal(
            name: 'Coffee amount',
            color: colorCoffeeStrong,
            min: 1.0,
            max: 100.0,
            value: recipe.coffeeAmount,
            onChanged: (value) {
              setState(() => recipe.coffeeAmount = value);
            },
          ),
          DialDecimal(
            name: 'Water amount',
            color: colorWaterWeak,
            min: 1.0,
            max: 1000.0,
            value: recipe.waterAmount,
            onChanged: (value) {
              setState(() => recipe.waterAmount = value);
            },
          ),
        ],
      ),
    );
  }
}

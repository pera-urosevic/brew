import 'package:brew/brew/actions/lock.dart';
import 'package:brew/brew/recipes.dart';
import 'package:brew/consts.dart';
import 'package:brew/size.dart';
import 'package:brew/models/recipe.dart';
import 'package:brew/models/book.dart';
import 'package:brew/brew/actions/recipes.dart';
import 'package:brew/brew/actions/save.dart';
import 'package:brew/brew/dial/numeric.dart';
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
    Recipe? recipeNew = bookLoadRecipe(name);
    debugPrint('Load recipe $name, $recipe');
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
        title: const Text('Brew'),
        actions: [
          ActionLock(
            icon: recipe.locked ? const Icon(Icons.lock) : const Icon(Icons.lock_open),
            onLock: () {
              setState(() => recipe.locked = !recipe.locked);
            },
          ),
          ActionSave(
            onSave: (name) async {
              debugPrint('Save recipe $name, $recipe');
              await bookSaveRecipe(name, recipe);
              setState(() => book = bookOpen());
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
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          DialNumeric(
            name: recipe.locked ? 'Coffee' : 'Coffee (unlocked)',
            color: colorCoffee,
            min: minCoffee,
            max: maxCoffee,
            value: recipe.coffee,
            speed: 0.1,
            onChanged: (value) {
              setState(() => recipe.coffee = value);
            },
          ),
          DialNumeric(
            name: recipe.locked ? 'Water' : 'Water (unlocked)',
            color: colorWater,
            min: minWater,
            max: maxWater,
            value: recipe.water,
            speed: 1.0,
            onChanged: (value) {
              setState(() => recipe.water = value);
            },
          ),
          DialNumeric(
            name: 'Grind',
            color: colorGrind,
            min: minGrind.toDouble(),
            max: maxGrind.toDouble(),
            incrementSmall: 1.0,
            incrementBig: 10.0,
            value: recipe.grind.toDouble(),
            speed: 0.04,
            onChanged: (value) {
              setState(() => recipe.grind = value.toInt());
            },
            formatter: (value) => value.toStringAsFixed(0),
          ),
          DialNumeric(
            name: 'Time',
            color: colorTime,
            min: minTime.toDouble(),
            max: maxTime.toDouble(),
            incrementSmall: 1.0,
            incrementBig: 60.0,
            speed: 1.0,
            value: recipe.time.toDouble(),
            onChanged: (value) {
              setState(() => recipe.time = value.toInt());
            },
            formatter: (value) {
              int seconds = value.toInt();
              int minutes = seconds ~/ 60;
              int remainingSeconds = seconds % 60;
              return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
            },
          ),
        ],
      ),
    );
  }
}

import 'dart:convert';
import 'package:brew/models/recipe.dart';
import 'package:brew/prefs.dart';

typedef Book = Set<String>;

Set<String> bookOpen() {
  Set<String> recipes = prefs.getKeys();
  recipes.remove('');
  return recipes;
}

Recipe? bookLoadRecipe(String name) {
  String? recipeJson = prefs.getString(name);
  if (recipeJson == null) return null;
  Recipe recipe = Recipe.fromJson(jsonDecode(recipeJson));
  return recipe;
}

bookSaveRecipe(String name, Recipe recipe) async {
  await prefs.setString(name, jsonEncode(recipe.toJson()));
}

bookRemoveRecipe(String name) async {
  await prefs.remove(name);
}

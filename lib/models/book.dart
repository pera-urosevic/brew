import 'dart:convert';
import 'package:brew/models/recipe.dart';
import 'package:brew/prefs.dart';

typedef Book = List<String>;

Book bookOpen() {
  Book book = List.from(prefs.getKeys());
  book.sort();
  book.remove('');
  return book;
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

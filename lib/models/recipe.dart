import 'dart:convert';

import 'package:brew/prefs.dart';

class Recipe {
  int _coffeeRatio;
  int _waterRatio;
  double _coffeeAmount;
  double _waterAmount;

  int get coffeeRatio => _coffeeRatio;
  int get waterRatio => _waterRatio;
  double get coffeeAmount => _coffeeAmount;
  double get waterAmount => _waterAmount;

  set coffeeRatio(int value) {
    if (value < 1 || value > 100) return;
    _coffeeAmount = _waterAmount * (value / _waterRatio);
    _coffeeRatio = value;
    save();
  }

  set waterRatio(int value) {
    if (value < 1 || value > 100) return;
    _waterAmount = _coffeeAmount / (_coffeeRatio / value);
    _waterRatio = value;
    save();
  }

  set coffeeAmount(double value) {
    value = double.parse(value.toStringAsFixed(1));
    if (value < 1 || value > 1000) return;
    _waterAmount = value / (_coffeeRatio / _waterRatio);
    _coffeeAmount = value;
    save();
  }

  set waterAmount(double value) {
    value = double.parse(value.toStringAsFixed(1));
    if (value < 1 || value > 1000) return;
    _coffeeAmount = value * (_coffeeRatio / _waterRatio);
    _waterAmount = value;
    save();
  }

  toJson() {
    return {
      'coffeeRatio': _coffeeRatio,
      'waterRatio': _waterRatio,
      'coffeeAmount': _coffeeAmount,
      'waterAmount': _waterAmount,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }

  Recipe({
    required int coffeeRatio,
    required int waterRatio,
    required double coffeeAmount,
    required double waterAmount,
  })  : _waterAmount = waterAmount,
        _waterRatio = waterRatio,
        _coffeeAmount = coffeeAmount,
        _coffeeRatio = coffeeRatio;

  factory Recipe.load() {
    String? recipeJson = prefs.getString('');
    Recipe recipe;
    if (recipeJson == null) {
      recipe = Recipe.defaultRecipe();
    } else {
      Map<String, dynamic> json = jsonDecode(recipeJson);
      recipe = Recipe(
        coffeeRatio: json['coffeeRatio'],
        waterRatio: json['waterRatio'],
        coffeeAmount: json['coffeeAmount'],
        waterAmount: json['waterAmount'],
      );
    }
    return recipe;
  }

  factory Recipe.defaultRecipe() {
    return Recipe(coffeeRatio: 1, waterRatio: 12, coffeeAmount: 20, waterAmount: 240);
  }

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      coffeeRatio: json['coffeeRatio'],
      waterRatio: json['waterRatio'],
      coffeeAmount: json['coffeeAmount'],
      waterAmount: json['waterAmount'],
    );
  }

  save() async {
    String recipeJson = jsonEncode({
      'coffeeRatio': _coffeeRatio,
      'waterRatio': _waterRatio,
      'coffeeAmount': _coffeeAmount,
      'waterAmount': _waterAmount,
    });
    await prefs.setString('', recipeJson);
  }

  clone() {
    return Recipe(
      coffeeRatio: _coffeeRatio,
      waterRatio: _waterRatio,
      coffeeAmount: _coffeeAmount,
      waterAmount: _waterAmount,
    );
  }
}

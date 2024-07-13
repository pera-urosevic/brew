import 'dart:convert';

import 'package:brew/consts.dart';
import 'package:brew/prefs.dart';

class Recipe {
  bool _locked;
  double _coffee;
  double _water;
  int _grind;
  int _time;

  bool get locked => _locked;
  double get coffee => _coffee;
  double get water => _water;
  int get grind => _grind;
  int get time => _time;

  set locked(bool value) {
    _locked = value;
    save();
  }

  set coffee(double value) {
    if (value < minCoffee || value > maxCoffee) return;
    if (locked) {
      double ratio = _water / _coffee;
      _water = value * ratio;
      _coffee = value;
    } else {
      _coffee = value;
    }
    save();
  }

  set water(double value) {
    if (value < minWater || value > maxWater) return;
    if (locked) {
      double ratio = _coffee / _water;
      _coffee = value * ratio;
      _water = value;
    } else {
      _water = value;
    }
    save();
  }

  set grind(int value) {
    if (value < minGrind || value > maxGrind) return;
    _grind = value;
    save();
  }

  set time(int value) {
    if (value < minTime || value > maxTime) return;
    _time = value;
    save();
  }

  toJson() {
    return {
      'locked': _locked,
      'coffee': (_coffee * 10).roundToDouble() / 10.0,
      'water': (_water * 10).roundToDouble() / 10.0,
      'grind': _grind,
      'time': _time,
    };
  }

  @override
  String toString() {
    return toJson().toString();
  }

  Recipe({
    required bool locked,
    required double coffee,
    required double water,
    required int grind,
    required int time,
  })  : _locked = locked,
        _water = water,
        _coffee = coffee,
        _grind = grind,
        _time = time;

  factory Recipe.load() {
    String? recipeJson = prefs.getString('');
    Recipe recipe;
    if (recipeJson == null) {
      recipe = Recipe.defaultRecipe();
    } else {
      Map<String, dynamic> json = jsonDecode(recipeJson);
      recipe = Recipe(
        locked: true,
        coffee: json['coffee'],
        water: json['water'],
        grind: json['grind'],
        time: json['time'],
      );
    }
    return recipe;
  }

  factory Recipe.defaultRecipe() {
    return Recipe(
      locked: false,
      coffee: 20,
      water: 240,
      grind: 1,
      time: 0,
    );
  }

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      locked: true,
      coffee: json['coffee'],
      water: json['water'],
      grind: json['grind'],
      time: json['time'],
    );
  }

  save() async {
    String recipeJson = jsonEncode(toJson());
    await prefs.setString('', recipeJson);
  }

  clone() {
    return Recipe(
      locked: _locked,
      coffee: _coffee,
      water: _water,
      grind: _grind,
      time: _time,
    );
  }
}

import 'package:brew/theme/colors.dart';
import 'package:flutter/material.dart';

ThemeData theme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: colorSurface,
    surface: colorSurface,
  ),
);

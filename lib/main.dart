import 'package:brew/brew.dart';
import 'package:brew/prefs.dart';
import 'package:brew/size.dart';
import 'package:brew/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    relativeSize = RelativeSize(context);
    return MaterialApp(
      title: 'Brew',
      theme: theme,
      home: const BrewPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

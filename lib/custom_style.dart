import 'package:flutter/material.dart';

class CustomStyle {
  static final _colorPalette colorPalette = _colorPalette();
  static final _fontSizes fontSizes = _fontSizes();
}

class _colorPalette {
//write your colors here
  Color cyan = Color.fromARGB(255, 200, 221, 242);
  Color darkGrey = Color.fromARGB(255, 194, 193, 193);
  Color lightGrey = Color.fromARGB(255, 237, 237, 237);
}

class _fontSizes {
  //write common font size here
  double smallFont = 15;
  double mediumFont = 25;
  double largeFont = 40;
}

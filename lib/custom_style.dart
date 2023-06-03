import 'package:flutter/material.dart';

class CustomStyle {
  static final _colorPalette colorPalette = _colorPalette();
  static final _fontSizes fontSizes = _fontSizes();
}

class _colorPalette {
//write your colors here
  Color cyan = Color.fromARGB(255, 157, 206, 255);
  Color lightestGrey = Color.fromARGB(255, 237, 237, 237);
  Color lightGrey = Color.fromARGB(255, 194, 193, 193);

  Color darkGrey = Color.fromARGB(255, 60, 60, 60);
  Color amber = Colors.amber.shade400;
  Color darkestGrey = Color.fromARGB(255, 30, 30, 30);
  Color black = Color.fromARGB(255, 0, 0, 0);
  Color white = Color.fromARGB(255, 255, 255, 255);
}

class _fontSizes {
  //write common font size here
  double smallFont = 15;
  double mediumFont = 25;
  double largeFont = 35;
}

Widget customTextField(
    {required TextEditingController textEditingController,
    required String hintText,
    required double width,
    bool enabled = true,
    void Function(String)? onchanged,
    void Function()? onEditingComplete,
    TextInputType? keyboardType,
    FocusNode? focusNode,
    Icon? icon}) {
  return SizedBox(
    width: width,
    child: TextField(
      enabled: enabled,
      onEditingComplete: onEditingComplete,
      maxLines: null,
      minLines: 4,
      focusNode: focusNode,
      keyboardType: keyboardType,
      onChanged: onchanged,
      controller: textEditingController,
      style: TextStyle(
        color: Colors.white,
        height: 1.15,
      ),
      decoration: InputDecoration(
          isCollapsed: true,
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(
                color: CustomStyle.colorPalette.lightGrey,
              )),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
            borderSide: BorderSide(
              width: 2.0,
              color: CustomStyle
                  .colorPalette.cyan, // Sets the border color when focused
            ),
          ),
          fillColor: CustomStyle.colorPalette.darkGrey,
          filled: true,
          hintMaxLines: null,
          hintText: hintText,
          hintStyle: TextStyle(
              color: CustomStyle.colorPalette.white,
              fontSize: CustomStyle.fontSizes.smallFont,
              fontWeight: FontWeight.w200),
          icon: icon,
          iconColor: CustomStyle.colorPalette.white),
      cursorColor: CustomStyle.colorPalette.darkestGrey,
    ),
  );
}

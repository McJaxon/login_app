import 'package:flutter/material.dart';

final cardDecoration = DecoratedBox(
  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
);

const decorate = InputDecoration(
    hintStyle: TextStyle(
        color: Colors.black,
        fontSize: 35,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic),
    filled: true,
    enabledBorder:
        OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15))));

const primary = BoxDecoration(color: Color.fromARGB(255, 224, 170, 170));

class Styles {
  static DecoratedBox cardDecorations = cardDecoration;
  static InputDecoration decorations = decorate;
  static BoxDecoration bgColor = primary;
  static Color textColor = const Color.fromARGB(255, 19, 17, 17);
  static TextStyle wordStyle = TextStyle(
      fontSize: 15,
      color: textColor,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.italic);
  static TextStyle headLine1 = TextStyle(
      fontSize: 30,
      color: textColor,
      fontWeight: FontWeight.w600,
      fontStyle: FontStyle.italic);
  static TextStyle headLine2 = TextStyle(
      fontSize: 20,
      color: textColor,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.italic);
}

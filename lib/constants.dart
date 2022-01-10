import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF3AC5C9);
const kSecondaryColor = Color(0xFF7B8490);
const kAnimationDuration = Duration(milliseconds: 200);

final RegExp phoneValidatorRegExp = RegExp(
    '^(([03+[2-9]|05+[6|8|9]|07+[0|6|7|8|9]|08+[1-9]|09+[1-4|6-9]]){3})+[0-9]{7}\$');

const MaterialColor baeminColor = MaterialColor(
  0xFF3AC5C9,
  <int, Color>{
    50: Color(0xFfefffff),
    100: Color(0xFF93ffff),
    200: Color(0xFF7bfdff),
    300: Color(0xFF61e6e9),
    400: Color(0xFF3AC5C9),
    500: Color(0xFF3AC5C9),
    600: Color(0xFF0fb0b4),
    700: Color(0xFF00abae),
    800: Color(0xFF009599),
    900: Color(0xFF008084),
  },
);

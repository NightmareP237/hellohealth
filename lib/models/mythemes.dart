import 'package:flutter/material.dart';

class MyThemes {
static final primaryColor = Colors.orange.shade300;
static final primary = Colors.orange;

static final darkTheme = ThemeData(
  scaffoldBackgroundColor: Colors.grey.shade900,
  primaryColorDark: primaryColor,
  colorScheme: ColorScheme.dark(primary: primary),
  dividerColor: Colors.white,
);
static final lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
    primaryColor: primaryColor,
  colorScheme: ColorScheme.light(primary: primary),
    dividerColor: Colors.black,
);
}
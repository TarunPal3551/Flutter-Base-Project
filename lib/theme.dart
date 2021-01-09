import 'package:flutter/material.dart';

final kAccentColor = Color(0xFFFC6A57);
final kAppBarColor = Color(0xFFF8F8FA);

final kAppTheme = ThemeData(
  brightness: Brightness.light,
  fontFamily: 'ProductSans',
).copyWith(
  primaryColor: kAccentColor,
  accentColor: kAccentColor,
  scaffoldBackgroundColor: kAppBarColor,
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      overlayColor: MaterialStateColor.resolveWith(
        (states) => kAccentColor.withOpacity(0.1),
      ),
      foregroundColor: MaterialStateColor.resolveWith((states) => kAccentColor),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: kAccentColor,
  ),
  appBarTheme: AppBarTheme(
    elevation: 0,
    color: kAppBarColor,
    iconTheme: IconThemeData(color: Colors.black),
    actionsIconTheme: IconThemeData(color: Colors.black),
  ),
  iconTheme: IconThemeData(color: Colors.black),
  pageTransitionsTheme: const PageTransitionsTheme(
    builders: <TargetPlatform, PageTransitionsBuilder>{
      TargetPlatform.android: ZoomPageTransitionsBuilder(),
      TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
    },
  ),
);
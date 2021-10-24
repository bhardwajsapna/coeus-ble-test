import 'package:flutter/material.dart';

class Constants {
  // Name
  static String appName = "Rhinestone";

  // Material Design Color
  static Color lightPrimary = Color(0xFFFFDAC1);
  static Color lightAccent = Color(0xFFFFDAC1);
  static Color lightBackground = Color(0xFFFFDAC1);

  static Color darkPrimary = Colors.black;
  static Color darkAccent = Color(0xFF3B72FF);
  static Color darkBackground = Colors.black;

  static Color grey = Color(0xff707070);
  static Color textPrimary = Color(0xFF486581);
  static Color textDark = Color(0xFF102A43);

  static Color backgroundColor = Color(0xFFF5F5F7);

  // Green
  static Color darkGreen = Color(0xFF3ABD6F);
  static Color lightGreen = Color(0xFFE2F0CB);

  // Yellow
  static Color darkYellow = Color(0xFF3ABD6F);
  static Color lightYellow = Color(0xFFFFDA7A);

  // Blue
  static Color darkBlue = Color(0xFF60A3D9);
  static Color lightBlue = Color(0xFFACE7FF);

  // Orange
  static Color darkOrange = Color(0xFFFFB74D);
  static Color transparent = Color(0x00FFB700);
  static Color white = Color(0xFFFFFFFF);

  static Color musturd = Color(0xffdec68a);
  static Color gray = Color(0xffd3cbc5);
  static Color greendull = Color(0xffcbdec0);
  static Color lightgreendull = Color(0xffd8e8cf);
  static Color dull_move = Color(0xffe7c5b1);
  static Color dull_light_purple = Color(0xffc6cae3);
  static Color dull_blue_gray = Color(0xffa4bbc9);
  static Color dull_light_blue = Color(0xff9ed2e8);
  static ThemeData lighTheme(BuildContext context) {
    return ThemeData(
      backgroundColor: lightBackground,
      primaryColor: lightPrimary,
      accentColor: lightAccent,
      cursorColor: lightAccent,
      scaffoldBackgroundColor: lightBackground,
      //textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
      appBarTheme: AppBarTheme(
        //textTheme: GoogleFonts.latoTextTheme(Theme.of(context).textTheme),
        iconTheme: IconThemeData(
          color: lightAccent,
        ),
      ),
    );
  }

  static double headerHeight = 228.5;
  static double paddingSide = 10.0;

/*
23 aug 21 - sreeni 

below variables are the global variables which are required to be used for api calls
TODO list
they are to be initialised during login page after successfull login.
These data are saved in secure storage. 
*/
  static String userId = '611ab9bc5322c3653e8064b3';
  static String deviceId = '123';
}

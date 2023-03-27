import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import '../shared_components/colors.dart';

ThemeData lightMode = ThemeData(
  bottomNavigationBarTheme:BottomNavigationBarThemeData(
    elevation: 0.0,
    backgroundColor: Colors.white,
    selectedItemColor: defaultColor,
    unselectedItemColor:Colors.grey,
    selectedLabelStyle: const TextStyle(
      fontFamily: 'Jannah',
    ),
  ),
  scaffoldBackgroundColor : Colors.white,
  primaryColor: defaultColor,
  floatingActionButtonTheme:  FloatingActionButtonThemeData(
    backgroundColor: defaultColor,
  ),
  appBarTheme : AppBarTheme(
      titleSpacing: 20.0,
      iconTheme: IconThemeData(
        color:defaultColor,
      ),
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
      ),
      backgroundColor: Colors.white,
      elevation: 0.0,
      titleTextStyle: TextStyle(
        color: defaultColor
      )
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
      overflow: TextOverflow.ellipsis,
    ),
  ),
);

ThemeData darkMode = ThemeData(
  primaryColor: defaultColor,
  floatingActionButtonTheme:  FloatingActionButtonThemeData(
    backgroundColor: defaultColor,
  ),
  scaffoldBackgroundColor: HexColor('333739'),
  appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor('333739'),
        statusBarIconBrightness: Brightness.light,
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      backgroundColor: HexColor('333739'),
      elevation: 0.0,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      )),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    unselectedItemColor: Colors.grey,
    selectedItemColor: defaultColor,
    selectedLabelStyle: const TextStyle(
      fontFamily: 'Jannah',
    ),
    backgroundColor: HexColor('333739'),
    elevation: 30.0,
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white),
  ),
);
import 'package:flutter/material.dart';
import 'package:todo/core/utilities/app_styles.dart';
import 'package:todo/core/utilities/colors_manager.dart';

class AppTheme{
  static ThemeData light=ThemeData(
    useMaterial3: false,
    colorScheme: ColorScheme.fromSeed(seedColor: ColorsManager.blue,primary: ColorsManager.blue,onPrimary: ColorsManager.white),
    scaffoldBackgroundColor: ColorsManager.lightBackground,
    appBarTheme: AppBarTheme(
      backgroundColor: ColorsManager.blue,
      titleTextStyle: LightStyle.appBarStyle,
      elevation: 0,
      shadowColor: Colors.transparent
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: ColorsManager.white,
      selectedItemColor: ColorsManager.blue,
      unselectedItemColor: ColorsManager.grey,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      elevation: 0,
      backgroundColor: ColorsManager.blue,
      shape: StadiumBorder(side: BorderSide(color: ColorsManager.white,width: 4)),
      foregroundColor: ColorsManager.white,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: ColorsManager.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20))
      )
    )
  );
  static ThemeData dark=ThemeData(
    scaffoldBackgroundColor: ColorsManager.darkBackground,

  );

}
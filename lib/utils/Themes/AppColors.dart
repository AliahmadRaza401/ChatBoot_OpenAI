// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../Fonts/AppFonts.dart';

class AppColors {
  static Color PRIMARY_COLOR = const Color(0xff000081);
  static Color lightColor = const Color(0xff76B5C5);
  static Color PRIMARY_COLOR_DARK = const Color(0xff0f073b);
  static Color backgroundColor = const Color(0xfff5f5f6);
  static Color lightPrimaryColor = const Color(0xffac9cff);
  static Color Light_Blue = const Color(0xff1CA089);
  static Color LIGHT_GREY_COLOR = const Color(0xFFEFEFF7);
  static Color BLACK = const Color(0xff000000);
  static Color GRAY = const Color(0xff959595);
  static Color TRANSPARENT_COLOR = Colors.transparent;
  static Color RED_COLOR = const Color(0xFFDC2E45);
  static Color WHITE_COLOR = const Color(0xffFFFFFF);
  static Color LoginBackGround = const Color(0xffF99417);
  static Color lightTextColor = const Color(0xff6B7280);
  static Color darkTextColor = const Color(0xff111827);
  static Color searchTextFieldColor = const Color(0xffEBF0F5);
  static Color beautyServiceTextColor = const Color(0xff494949);
  static Color darkColorText = const Color(0xff1A1A1A);
  static Color bottomTopColor = const Color(0xffEDEFFB);
  static Color orangeColor = const Color(0xffFFA72A);
  static Color greenColor = const Color(0xff27AE60);
}

class GetTheme extends GetxController {
  var isDark = true.obs;

  updateMode() {
    isDark.value = true;
    ThemeHelper().switchTheme();
    isDark.value = false;
    update();
  }
}

class ThemeHelper {
  final _box = GetStorage();

  ThemeMode get theme => _loadThemeFromBox() ? ThemeMode.dark : ThemeMode.light;

  bool _loadThemeFromBox() => _box.read('') ?? false;

  _saveThemeToBox(bool isDarkMode) => _box.write('', isDarkMode);

  void switchTheme() {
    Get.changeThemeMode(_loadThemeFromBox() ? ThemeMode.light : ThemeMode.dark);

    _saveThemeToBox(!_loadThemeFromBox());
  }
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.PRIMARY_COLOR,
    primaryColor: AppColors.PRIMARY_COLOR,
    primarySwatch: Colors.teal,
    brightness: Brightness.light,
    cardColor: AppColors.WHITE_COLOR,
    textTheme: TTextTheme.lightTextTheme,
    appBarTheme: const AppBarTheme(),
    floatingActionButtonTheme: FloatingActionButtonThemeData(),
    elevatedButtonTheme:
        ElevatedButtonThemeData(style: ElevatedButton.styleFrom()),
  );
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.PRIMARY_COLOR,
    primaryColor: AppColors.PRIMARY_COLOR,
    primarySwatch: Colors.teal,
    brightness: Brightness.dark,
    textTheme: TTextTheme.darkTextTheme,
    appBarTheme: const AppBarTheme(),
    cardColor: const Color(0xff2f3e46),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(),
    elevatedButtonTheme:
        ElevatedButtonThemeData(style: ElevatedButton.styleFrom()),
  );
}

class TTextTheme {
  static TextTheme lightTextTheme = TextTheme(
    headline1: TextStyle(
        color: AppColors.BLACK,
        fontSize: 24,
        fontFamily: Weights.londrinaRegular),
    headline2: TextStyle(
        color: AppColors.BLACK,
        fontSize: 22,
        fontFamily: Weights.londrinaRegular),
    headline3: TextStyle(
        color: AppColors.BLACK,
        fontSize: 20,
        fontFamily: Weights.londrinaRegular),
    headline4: TextStyle(
        color: AppColors.BLACK,
        fontSize: 18,
        fontFamily: Weights.londrinaLight),
    headline5: TextStyle(
        color: AppColors.BLACK,
        fontSize: 16,
        fontFamily: Weights.londrinaLight),
    headline6: TextStyle(
        color: AppColors.BLACK,
        fontSize: 10,
        fontFamily: Weights.londrinaLight),

    //subtitle2: GoogleFonts.poppins(color: Colors.deepPurple, fontSize: 24),
  );
  static TextTheme darkTextTheme = TextTheme(
    headline1: TextStyle(
        color: AppColors.WHITE_COLOR,
        fontSize: 24,
        fontFamily: Weights.londrinaRegular),
    headline2: TextStyle(
        color: AppColors.WHITE_COLOR,
        fontSize: 22,
        fontFamily: Weights.londrinaRegular),
    headline3: TextStyle(
        color: AppColors.WHITE_COLOR,
        fontSize: 20,
        fontFamily: Weights.londrinaRegular),
    headline4: TextStyle(
        color: AppColors.WHITE_COLOR,
        fontSize: 18,
        fontFamily: Weights.londrinaLight),
    headline5: TextStyle(
        color: AppColors.WHITE_COLOR,
        fontSize: 16,
        fontFamily: Weights.londrinaLight),
    headline6: TextStyle(
        color: AppColors.WHITE_COLOR,
        fontSize: 10,
        fontFamily: Weights.londrinaLight),
  );
}

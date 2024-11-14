import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';
import '../utils/app_text_style.dart';

ThemeData appTheme() {
  return ThemeData(
    primaryColor: AppColors.primary,
    //scaffoldBackgroundColor
    scaffoldBackgroundColor: AppColors.background,
    //appBar theme
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.white,
      centerTitle: false,
      elevation: 0.0,
      titleTextStyle: largStyle(),
    ),

    // textTheme
    textTheme: TextTheme(
      headlineLarge: headlineBoldStyle(),
      bodyLarge: largStyle(),
      bodyMedium: mediumStyle(),
      bodySmall: regularStyle(),
    ),

    // elevated button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(AppColors.white),
        backgroundColor: WidgetStateProperty.all(AppColors.primary),
        textStyle: WidgetStatePropertyAll(mediumStyle()),
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    ),

    // text button
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(AppColors.primary),
        textStyle: WidgetStatePropertyAll(regularBoldStyle()),
      ),
    ),

    // floating action button
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        shape: CircleBorder()),

    // input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      filled: true,
      fillColor: AppColors.lightBlack,
      hintStyle: regularStyle(),
    ),

    // date picker theme
    datePickerTheme: DatePickerThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.r),
      ),
      dayStyle: regularStyle(),
    ),

    // bottom sheet
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.lightBlack,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      showDragHandle: true,
    ),

    // dialog
    dialogTheme: DialogTheme(
      backgroundColor: AppColors.lightBlack,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      titleTextStyle: largStyle(
        color: AppColors.orange,
      ),
      contentTextStyle: regularStyle(),
    ),
  );
}

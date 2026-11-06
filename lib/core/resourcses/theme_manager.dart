import 'package:tradly/core/resourcses/colors_manager.dart';
import 'package:tradly/core/resourcses/fonts_manager.dart';
import 'package:tradly/core/resourcses/styles_manager.dart';
import 'package:tradly/core/resourcses/values_manager.dart';
import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    // Main colors
    primaryColor: ColorManager.primary,
    disabledColor: ColorManager.grey,
    // Card theme
    cardTheme: CardThemeData(
      color: ColorManager.white,
      elevation: AppSize.s1_5,
      shadowColor: ColorManager.grey,
    ),
    // AppBar theme
    appBarTheme: AppBarTheme(
      backgroundColor: ColorManager.primary,
      elevation: AppSize.s0,
      centerTitle: true,
      titleTextStyle: getBoldStyle(
        color: ColorManager.white,
        fontSize: FontSize.s24,
      ),
    ),
    // elevatedbutton theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorManager.lightPrimary,
        disabledBackgroundColor: ColorManager.grey,
        textStyle: getMeduimStyle(
          color: ColorManager.white,
          fontSize: FontSize.s16,
        ),
        elevation: 0,
      ),
    ),

    // Text theme
    textTheme: TextTheme(
      headlineLarge: getMeduimStyle(
        // -->
        color: ColorManager.white,
        fontSize: FontSize.s24,
      ),
      titleLarge: getBoldStyle(
        // -->
        color: ColorManager.white,
        fontSize: FontSize.s24,
      ),
      displayMedium: getMeduimStyle(
        // -->
        color: ColorManager.primary,
        fontSize: FontSize.s20,
      ),
      labelSmall: getRegularStyle(
        color: ColorManager.white,
        fontsize: FontSize.s16,
      ),
      titleSmall: getRegularStyle(
        // -->
        color: ColorManager.white,
        fontsize: FontSize.s18,
      ),
      displaySmall: getMeduimStyle(
        color: ColorManager.white,
        fontSize: FontSize.s16,
      ),
      bodySmall: getRegularStyle(
        // -->
        color: ColorManager.darkGrey,
        fontsize: FontSize.s14,
      ),
      bodyMedium: getSemiBoldStyle(
        // -->
        color: ColorManager.white,
        fontSize: FontSize.s18,
      ),
      titleMedium: getMeduimStyle(
        // -->
        color: ColorManager.white,
        fontSize: FontSize.s16,
      ),
      headlineMedium: getBoldStyle(
        // -->
        color: ColorManager.darkGrey,
        fontSize: FontSize.s18,
      ),
      headlineSmall: getMeduimStyle(
        // -->
        color: ColorManager.white,
        fontSize: FontSize.s12,
      ),
      bodyLarge: getMeduimStyle(
        color: ColorManager.black,
        fontSize: FontSize.s12,
      ),
      labelLarge: getSemiBoldStyle(
        color: ColorManager.white,
        fontSize: FontSize.s12,
      ),
      displayLarge: getBoldStyle(
        // -->
        color: ColorManager.white,
        fontSize: FontSize.s18,
      ),
    ),
    // Input decoration theme(text form field)
    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(AppPadding.p8),
      hintStyle: getRegularStyle(
        color: ColorManager.white,
        fontsize: FontSize.s18,
      ),
      labelStyle: getMeduimStyle(
        color: ColorManager.white,
        fontSize: FontSize.s14,
      ),
      errorStyle: getRegularStyle(color: ColorManager.red),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s24)),
        borderSide: BorderSide(color: ColorManager.white, width: AppSize.s1_5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s24)),
        borderSide: BorderSide(
          color: ColorManager.primary,
          width: AppSize.s1_5,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: ColorManager.red, width: AppSize.s1_5),
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s24)),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(AppSize.s24)),
        borderSide: BorderSide(color: ColorManager.red, width: AppSize.s1_5),
      ),
    ),
  );
}

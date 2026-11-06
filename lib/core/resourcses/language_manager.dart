import 'package:flutter/material.dart';

enum LanguageType { english, arabic }

const String english = "en";

const String arabic = "ar";

const Locale arabicLocale = Locale("ar", "SA");
const Locale englishLocale = Locale("en", "US");

const String localizationsPath = "assets/translations";

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.english:
        return english;
      case LanguageType.arabic:
        return arabic;
    }
  }
}

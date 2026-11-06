import 'package:flutter/material.dart';
import 'package:tradly/core/resourcses/language_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String prefsKeyLanguage = "prefsKeyLanguage";
const String prefsKeyOnBoardingScreenViewed = "prefsKeyOnBoardingScreenViewed";
const String prefsKeyIsUserLoggedIn = "prefsKeyIsUserLoggedIn";
const String prefsKeyIsUserRegisterd = "prefsKeyIsUserRegisterd";

class AppPreferences {
  final SharedPreferences _sharedPreferences;

  AppPreferences(this._sharedPreferences);

  Future<String> getAppLanguage() async {
    String? language = _sharedPreferences.getString(prefsKeyLanguage);
    if (language != null && language.isNotEmpty) {
      return language;
    } else {
      //return default language
      return LanguageType.english.getValue();
    }
  }

  Future<void> changeAppLanguage() async {
    String currentLanguage = await getAppLanguage();

    if (currentLanguage == LanguageType.arabic.getValue()) {
      _sharedPreferences.setString(
        prefsKeyLanguage,
        LanguageType.english.getValue(),
      );
    } else {
      _sharedPreferences.setString(
        prefsKeyLanguage,
        LanguageType.arabic.getValue(),
      );
    }
  }

  Future<Locale> getAppLocale() async {
    String currentLanguage = await getAppLanguage();

    if (currentLanguage == LanguageType.arabic.getValue()) {
      return arabicLocale;
    } else {
      return englishLocale;
    }
  }

  // On boarding
  Future<void> setOnBoardingScreenViewed() async {
    _sharedPreferences.setBool(prefsKeyOnBoardingScreenViewed, true);
  }

  Future<bool> isOnBoardingScreenViewed() async {
    return _sharedPreferences.getBool(prefsKeyOnBoardingScreenViewed) ?? false;
  }

  // login
  Future<void> setUserLoggedIn() async {
    _sharedPreferences.setBool(prefsKeyIsUserLoggedIn, true);
  }

  Future<bool> isUserLoggedIn() async {
    return _sharedPreferences.getBool(prefsKeyIsUserLoggedIn) ?? false;
  }

  // regsiter
  Future<void> setUserRegistered() async {
    _sharedPreferences.setBool(prefsKeyIsUserRegisterd, true);
  }

  Future<bool> isUserRegistered() async {
    return _sharedPreferences.getBool(prefsKeyIsUserRegisterd) ?? false;
  }

  Future<void> logOut() async {
    _sharedPreferences.remove(prefsKeyIsUserLoggedIn);
  }
}

import 'package:flutter/material.dart';
import 'package:tradly/core/utils/app_prefs.dart';
import 'package:tradly/core/di/di.dart';
import '../resourcses/routes_manager.dart';
import '../resourcses/theme_manager.dart';
import 'package:easy_localization/easy_localization.dart';

class TradlyApp extends StatefulWidget {
  // named constructor
  const TradlyApp._internal();

  // singleton or single instance
  static const TradlyApp _instance = TradlyApp._internal();

  factory TradlyApp() => _instance; // factory

  @override
  State<TradlyApp> createState() => _TradlyAppState();
}

class _TradlyAppState extends State<TradlyApp> {
  final AppPreferences _appPreferences = instance<AppPreferences>();

  @override
  void didChangeDependencies() {
    _appPreferences.getAppLocale().then((local) => context.setLocale(local));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: getApplicationTheme(),
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.splashScreen,
      onGenerateRoute: RouteGenerator.getRoute,
    );
  }
}

import 'dart:async';

import 'package:tradly/core/utils/app_prefs.dart';
import 'package:tradly/core/di/di.dart';
import 'package:tradly/core/resourcses/assets_manager.dart';
import 'package:tradly/core/resourcses/colors_manager.dart';
import 'package:tradly/core/resourcses/constants.dart';
import 'package:tradly/core/resourcses/routes_manager.dart';
import 'package:tradly/core/resourcses/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  Timer? _timer;
  final AppPreferences _appPreferences = instance<AppPreferences>();

  void _startDelay() {
    _timer = Timer(const Duration(seconds: AppConstants.splashDelay), _goNext);
  }

  void _goNext() async {
    bool isUserLoggedIn = await _appPreferences.isUserLoggedIn();
    if (!mounted) return;

    if (isUserLoggedIn) {
      Navigator.of(context).pushReplacementNamed(Routes.homeScreen);
    } else {
      bool isOnBoardingScreenViewed = await _appPreferences
          .isOnBoardingScreenViewed();
      if (!mounted) return;

      if (isOnBoardingScreenViewed) {
        Navigator.of(context).pushReplacementNamed(Routes.loginScreen);
      } else {
        Navigator.of(context).pushReplacementNamed(Routes.onBoardingScreen);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: AppBar(
        elevation: AppSize.s0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.primary,
          statusBarIconBrightness: Brightness.light,
        ),
      ),
      body: const Center(
        child: Image(image: AssetImage(ImageAssets.splashLogo)),
      ),
    );
  }
}

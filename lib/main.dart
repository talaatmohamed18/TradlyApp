import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:tradly/core/storage/hive_config.dart';
import 'package:tradly/core/env/env.dart';
import 'package:tradly/features/cart/data/data_source/cart_local_data_source.dart';
import 'package:tradly/features/wishlist/data/data_source/wishlist_local_data_source.dart';
import 'package:tradly/core/resourcses/language_manager.dart';
import 'core/utils/app.dart';
import 'core/di/di.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = Env.publishKey;
  await initAppModule();
  await HiveConfig.initHive();
  await Future.wait([
    EasyLocalization.ensureInitialized(),
    instance<CartLocalDataSource>().init(),
    instance<WishlistLocalDataSource>().init(),
    Stripe.instance.applySettings(),
  ]);
  runApp(
    ProviderScope(
      child: EasyLocalization(
        supportedLocales: [arabicLocale, englishLocale],
        path: localizationsPath,
        child: Phoenix(child: TradlyApp()),
      ),
    ),
  );
}

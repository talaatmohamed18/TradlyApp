import 'package:hive_ce_flutter/hive_flutter.dart';

import '../../features/cart/data/data_source/cart_local_data_source.dart';
import '../../features/cart/data/model/cart_item_model.dart';
import '../../features/cart/data/model/cart_product_model.dart';
import '../../features/wishlist/data/model/wishlist_product_model.dart';
import '../di/di.dart';

class HiveConfig {
  static final cartLocalDataSource = instance<CartLocalDataSource>();

  static Future<void> initHive() async {
    await Hive.initFlutter();

    Hive.registerAdapter(CartProductModelAdapter());
    Hive.registerAdapter(CartItemModelAdapter());
    Hive.registerAdapter(WishlistProductModelAdapter());
  }
}

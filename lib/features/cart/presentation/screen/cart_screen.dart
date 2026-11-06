import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tradly/features/cart/presentation/widgets/cart_body.dart';
import 'package:tradly/features/cart/presentation/provider/cart_provider.dart';
import 'package:tradly/features/checkout/presentation/provider/address_provider.dart';
import 'package:tradly/core/resourcses/colors_manager.dart';
import 'package:tradly/core/resourcses/strings_manager.dart';

class CartView extends ConsumerWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final address = ref.watch(addressProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.cart.tr()),
        iconTheme: IconThemeData(color: ColorManager.white),
      ),
      body: cart.isEmpty
          ? Center(
              child: Text(
                AppStrings.emptyCart.tr(),
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(color: ColorManager.black),
              ),
            )
          : CartBody(cart: cart, address: address),
    );
  }
}

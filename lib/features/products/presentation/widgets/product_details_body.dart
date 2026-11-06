import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tradly/features/products/domain/entity/product.dart';
import 'package:tradly/features/cart/presentation/provider/cart_provider.dart';
import 'package:tradly/features/wishlist/presentation/provider/wishlist_provider.dart';
import 'package:tradly/core/resourcses/assets_manager.dart';
import 'package:tradly/core/resourcses/colors_manager.dart';
import 'package:tradly/core/resourcses/strings_manager.dart';
import 'package:tradly/core/resourcses/values_manager.dart';

class ProductDetailsBody extends ConsumerWidget {
  final Product product;
  const ProductDetailsBody({super.key, required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavourite = ref.watch(
      wishListProvider.select(
        (products) => products.any((item) => item.id == product.id),
      ),
    );
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
        elevation: 0,
        iconTheme: IconThemeData(color: ColorManager.primary),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.share, color: ColorManager.primary),
          ),
          IconButton(
            onPressed: () {
              ref.read(wishListProvider.notifier).toggleFavourite(product);
            },
            icon: Icon(
              isFavourite ? Icons.favorite : Icons.favorite_border,
              color: ColorManager.primary,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu, color: ColorManager.primary),
          ),
        ],
      ),
      body: Container(
        color: ColorManager.white,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(child: _getItems(product, context)),
            ),
            SafeArea(
              top: false,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppMargin.m28,
                  vertical: AppMargin.m8,
                ),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      ref.read(cartProvider.notifier).addToCart(product);
                    },
                    child: Text(
                      AppStrings.addToCart.tr(),
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getItems(Product? product, BuildContext context) {
    if (product != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Image.network(
              product.thumbnail,
              fit: BoxFit.contain,
              width: double.infinity,
              height: (MediaQuery.sizeOf(context).height * 0.3)
                  .clamp(180.0, 280.0)
                  .toDouble(),
            ),
          ),
          ListTile(
            title: Text(product.title),
            subtitle: Row(
              children: [
                Text((product.price * 0.5).toString()),
                SizedBox(width: 20),
                Text("\$ ${product.price}\t 50% off "),
              ],
            ),
          ),
          Container(height: 4, color: const Color.fromARGB(255, 200, 236, 255)),
          Container(
            height: 50,
            alignment: AlignmentGeometry.center,
            child: ListTile(
              leading: SvgPicture.asset(ImageAssets.tAvatar),
              title: Text(product.category.toUpperCase()),
              trailing: TextButton(
                onPressed: () {},
                child: Text(AppStrings.follow.tr()),
              ),
            ),
          ),
          Container(height: 4, color: const Color.fromARGB(255, 200, 236, 255)),
          _getSection(AppStrings.about.tr()),
          _getInfoText(product.description, context),
          _getSection(AppStrings.details.tr()),
          _getInfoText(product.description, context),
        ],
      );
    }
    return Container();
  }

  Widget _getSection(String title) {
    return Padding(
      padding: EdgeInsets.only(
        top: AppPadding.p12,
        left: AppPadding.p12,
        right: AppPadding.p12,
        bottom: AppPadding.p4,
      ),
      child: Text(title, style: TextStyle(color: Colors.black)),
    );
  }

  Widget _getInfoText(String info, BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(AppPadding.p12),
      child: Text(
        "$info $info $info",
        style: Theme.of(context).textTheme.bodySmall,
      ),
    );
  }
}

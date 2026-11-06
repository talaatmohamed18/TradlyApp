import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tradly/core/utils/responsive.dart';
import 'package:tradly/features/products/domain/entity/product.dart';
import 'package:tradly/core/widgets/card_view.dart';
import 'package:tradly/core/widgets/categories_widget.dart';
import 'package:tradly/core/widgets/title_with_seeall_btn.dart';
import 'package:tradly/features/products/presentation/screen/product_details_screen.dart';
import 'package:tradly/core/resourcses/colors_manager.dart';
import 'package:tradly/core/resourcses/strings_manager.dart';
import 'package:tradly/core/resourcses/values_manager.dart';

class HomeContent extends StatelessWidget {
  final List<Product> homeData;
  const HomeContent({super.key, required this.homeData});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _getBannerWidget(homeData, context),
          _getCategoryWidget(homeData, context),
          TitleWithSeeAllBtn(
            title: AppStrings.newProduct.tr(),
            btnTitle: AppStrings.seeAll.tr(),
            btnPress: () {},
          ),
          _getProductWidget(homeData, context),
          TitleWithSeeAllBtn(
            title: AppStrings.popularProduct.tr(),
            btnTitle: AppStrings.seeAll.tr(),
            btnPress: () {},
          ),
          _getProductWidget(homeData, context),
        ],
      ),
    );
  }

  Widget _getBannerWidget(List<Product>? banners, BuildContext context) {
    if (banners != null) {
      final bannerHeight = (Responsive.height(context) * 0.25)
          .clamp(150.0, 220.0)
          .toDouble();
      return Padding(
        padding: const EdgeInsets.only(
          top: AppPadding.p4,
          bottom: AppPadding.p8,
        ),
        child: CarouselSlider(
          items: banners.map((banner) {
            return SizedBox(
              width: double.infinity,
              child: Card(
                elevation: AppSize.s1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s12),
                  side: BorderSide(
                    color: ColorManager.lightPrimary,
                    width: AppSize.s1,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppSize.s12),
                  child: Image.network(banner.thumbnail, fit: BoxFit.fill),
                ),
              ),
            );
          }).toList(),
          options: CarouselOptions(
            autoPlay: true,
            enableInfiniteScroll: true,
            height: bannerHeight,
            enlargeCenterPage: true,
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  // TODO:: Modify Categories Later
  Widget _getCategoryWidget(List<Product>? categories, BuildContext context) {
    if (categories != null) {
      final crossAxisCount = Responsive.isCompact(context) ? 3 : 4;
      final tileSize = Responsive.width(context) / crossAxisCount;
      return SizedBox(
        width: double.infinity,
        height: tileSize * 2,
        child: GridView.builder(
          primary: false,
          itemCount: categories.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 1.5,
            mainAxisSpacing: 1.5,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            return CategoriesWidget(
              category: categories[index].category,
              image: categories[index].thumbnail,
            );
          },
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _getProductWidget(List<Product>? products, BuildContext context) {
    if (products != null) {
      return SizedBox(
        width: double.infinity,
        height: 205,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: AppPadding.p12),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return CardView(
              image: product.thumbnail,
              name: product.title,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>
                        ProductDetailsScreen(productId: product.id),
                  ),
                );
              },
            );
          },
        ),
      );
    } else {
      return Container();
    }
  }
}

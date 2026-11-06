import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tradly/features/products/presentation/screen/product_details_screen.dart';
import 'package:tradly/features/browse/presentation/providers/search_products_notifier.dart';
import 'package:tradly/features/browse/presentation/providers/search_query_provider.dart';
import 'package:tradly/core/resourcses/colors_manager.dart';
import 'package:tradly/core/resourcses/strings_manager.dart';
import 'package:tradly/core/resourcses/values_manager.dart';

class BrowsePage extends ConsumerWidget {
  const BrowsePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(searchQueryProvider);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: TextField(
            onChanged: (value) {
              ref.read(searchQueryProvider.notifier).updateQuery(value);
            },
            decoration: InputDecoration(
              hintText: AppStrings.search.tr(),
              hintStyle: TextStyle(color: ColorManager.primary),
              prefixIcon: Icon(Icons.search),
              enabledBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(AppSize.s24),
                ),
                borderSide: BorderSide(
                  color: ColorManager.primary,
                  width: AppSize.s1_5,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: query.isEmpty
              ? Center(
                  child: Text(
                    AppStrings.search.tr(),
                    style: TextStyle(color: ColorManager.black),
                  ),
                )
              : _SearchResults(query: query),
        ),
      ],
    );
  }
}

class _SearchResults extends ConsumerWidget {
  final String query;

  const _SearchResults({required this.query});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(searchProductsProvider(query));
    return state.when(
      loading: () {
        return const Center(child: CircularProgressIndicator());
      },
      error: (error, stackTrace) {
        return Center(child: Text(error.toString()));
      },
      data: (products) {
        if (products.isEmpty) {
          return Center(
            child: Text(
              AppStrings.noProductFound.tr(),
              style: TextStyle(color: ColorManager.black),
            ),
          );
        }
        return ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return ListTile(
              leading: Image.network(
                product.thumbnail,
                width: 60,
                height: 60,
                fit: BoxFit.cover,
              ),
              title: Text(product.title),
              subtitle: Text('\$${product.price}'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) {
                      return ProductDetailsScreen(productId: product.id);
                    },
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}

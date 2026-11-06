import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tradly/core/di/di.dart';
import 'package:tradly/features/products/domain/entity/product.dart';
import 'package:tradly/features/products/domain/usecase/get_category_products_usecase.dart';

class CategoryProductsNotifier extends AsyncNotifier<List<Product>> {
  final GetCategoryProductsUsecase _usecase =
      instance<GetCategoryProductsUsecase>();
  final String category;
  CategoryProductsNotifier(this.category);
  @override
  Future<List<Product>> build() async {
    final response = await _usecase.execute(category);
    return response.fold(
      (failure) {
        throw Exception(failure.message);
      },
      (products) {
        return products;
      },
    );
  }
}

final categoryProductsProvider =
    AsyncNotifierProvider.family<
      CategoryProductsNotifier,
      List<Product>,
      String
    >(CategoryProductsNotifier.new);

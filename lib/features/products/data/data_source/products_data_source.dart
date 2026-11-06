import 'package:tradly/core/network/products_api.dart';
import 'package:tradly/features/products/data/model/product_model.dart';
import 'package:tradly/features/products/data/model/products_response_model.dart';

abstract class ProductsDataSource {
  Future<ProductsResponseModel> getProducts({
    required int limit,
    required int skip,
  });

  Future<ProductModel> getProductDetails(int id);

  Future<ProductsResponseModel> searchProduct(String query);

  Future<ProductsResponseModel> getCategoryProducts(String category);
}

class ProductsDataSourceImpl implements ProductsDataSource {
  final AppApi _appApi;

  ProductsDataSourceImpl(this._appApi);

  @override
  Future<ProductsResponseModel> getProducts({
    required int limit,
    required int skip,
  }) async {
    return await _appApi.getProducts(limit, skip);
  }

  @override
  Future<ProductModel> getProductDetails(int id) async {
    return await _appApi.getProductDetails(id);
  }

  @override
  Future<ProductsResponseModel> searchProduct(String query) async {
    return await _appApi.searchProduct(query);
  }

  @override
  Future<ProductsResponseModel> getCategoryProducts(String category) async {
    return await _appApi.getCategoryProducts(category);
  }
}

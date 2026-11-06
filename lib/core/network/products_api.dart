import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../features/products/data/model/product_model.dart';
import '../../features/products/data/model/products_response_model.dart';
import '../utils/constants.dart';

part 'products_api.g.dart';

@RestApi(baseUrl: AppConstants.testUrl)
abstract class AppApi {
  factory AppApi(Dio dio, {String? baseUrl}) = _AppApi;

  @GET("/products")
  Future<ProductsResponseModel> getProducts(
    @Query('limit') int limit,
    @Query('skip') int skip,
  );

  @GET("/products/{id}")
  Future<ProductModel> getProductDetails(@Path('id') int id);

  @GET("/products/search")
  Future<ProductsResponseModel> searchProduct(@Query("q") String query);

  @GET("/products/category/{category}")
  Future<ProductsResponseModel> getCategoryProducts(
    @Path('category') String category,
  );
}

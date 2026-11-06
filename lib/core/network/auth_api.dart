import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../features/authentication/data/model/responses.dart';
import '../utils/constants.dart';

part 'auth_api.g.dart';

@RestApi(baseUrl: AppConstants.baseUrl)
abstract class AppServiceClient {
  // named constructor
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  //interface خاصه بال login
  @POST("/customers/login")
  Future<AuthenticationResponse> login(
    @Field("email") String email,
    @Field("password") String password,
  );

  //interface خاصه بال register
  @POST("/customers/register")
  Future<AuthenticationResponse> register(
    @Field("firstName") String firstName,
    @Field("lastName") String lastName,
    @Field("email") String email,
    @Field("password") String password,
  );

  //interface خاصه بال forgot password
  @POST("/customers/resetPassword")
  Future<ResetPasswordResponse> resetPassword(@Field("email") String email);
}

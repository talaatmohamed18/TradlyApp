import 'package:dartz/dartz.dart';

import '../../../../core/error/error_handler.dart';
import '../../../../core/error/failure.dart';
import '../../domain/entity/user.dart';
import '../../domain/repository/authentication_repository.dart';
import '../datasource/authentication_data_source.dart';
import '../mapper/mapper.dart';
import '../model/requests.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationDataSource _authenticationDataSource;

  AuthenticationRepositoryImpl(this._authenticationDataSource);

  // LOGIN
  @override
  Future<Either<Failure, Authentication>> login(
    LoginRequest loginRequest,
  ) async {
    try {
      final response = await _authenticationDataSource.login(loginRequest);
      if (response.status == ApiInternalStatus.success) {
        return Right(response.toDomain());
      } else {
        return Left(
          Failure(
            ApiInternalStatus.failure,
            response.message ?? ResponseMessage.defaultObject,
          ),
        );
      }
    } catch (error) {
      return left(ErrorHandler.handle(error).failure);
    }
  }

  // REGISTER
  @override
  Future<Either<Failure, Authentication>> register(
    RegisterRequest registerRequest,
  ) async {
    try {
      final response = await _authenticationDataSource.register(
        registerRequest,
      );
      if (response.status == ApiInternalStatus.success) {
        return Right(response.toDomain());
      } else {
        return Left(
          Failure(
            ApiInternalStatus.failure,
            response.message ?? ResponseMessage.defaultObject,
          ),
        );
      }
    } catch (error) {
      return left(ErrorHandler.handle(error).failure);
    }
  }

  // Reset PASSWORD
  @override
  Future<Either<Failure, ResetPassword>> resetPassword(String email) async {
    try {
      final response = await _authenticationDataSource.resetPassword(email);
      if (response.status == ApiInternalStatus.success) {
        return Right(response.toDomain());
      } else {
        return Left(
          Failure(
            ApiInternalStatus.failure,
            response.message ?? ResponseMessage.defaultObject,
          ),
        );
      }
    } catch (error) {
      return left(ErrorHandler.handle(error).failure);
    }
  }
}

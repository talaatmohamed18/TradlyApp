import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../data/model/requests.dart';
import '../entity/user.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, Authentication>> login(LoginRequest loginRequest);

  Future<Either<Failure, Authentication>> register(
    RegisterRequest registerRequest,
  );

  Future<Either<Failure, ResetPassword>> resetPassword(String email);
}

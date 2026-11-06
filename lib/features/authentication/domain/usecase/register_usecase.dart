import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/base_usecase.dart';
import '../../data/model/requests.dart';
import '../entity/user.dart';
import '../repository/authentication_repository.dart';

class RegisterUsecase
    extends BaseUsecase<RegisterUsecaseInput, Authentication> {
  final AuthenticationRepository _authenticationRepository;

  RegisterUsecase(this._authenticationRepository);

  @override
  Future<Either<Failure, Authentication>> execute(input) async {
    return await _authenticationRepository.register(
      RegisterRequest(
        input.firstName,
        input.lastName,
        input.email,
        input.password,
      ),
    );
  }
}

class RegisterUsecaseInput {
  String firstName;
  String lastName;
  String email;
  String password;

  RegisterUsecaseInput(
    this.firstName,
    this.lastName,
    this.email,
    this.password,
  );
}

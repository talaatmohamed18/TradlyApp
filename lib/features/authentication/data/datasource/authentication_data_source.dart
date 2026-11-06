import '../../../../core/network/auth_api.dart';
import '../model/requests.dart';
import '../model/responses.dart';

abstract class AuthenticationDataSource {
  Future<AuthenticationResponse> login(LoginRequest loginRequest);

  Future<AuthenticationResponse> register(RegisterRequest registerRequest);

  Future<ResetPasswordResponse> resetPassword(String email);
}

class AuthenticationDataSourceImpl implements AuthenticationDataSource {
  final AppServiceClient _appServiceClient;

  AuthenticationDataSourceImpl(this._appServiceClient);

  @override
  Future<AuthenticationResponse> login(LoginRequest loginRequest) async {
    return await _appServiceClient.login(
      loginRequest.email,
      loginRequest.password,
    );
  }

  @override
  Future<AuthenticationResponse> register(
    RegisterRequest registerRequest,
  ) async {
    return await _appServiceClient.register(
      registerRequest.firstName,
      registerRequest.lastName,
      registerRequest.email,
      registerRequest.password,
    );
  }

  @override
  Future<ResetPasswordResponse> resetPassword(String email) async {
    return await _appServiceClient.resetPassword(email);
  }
}

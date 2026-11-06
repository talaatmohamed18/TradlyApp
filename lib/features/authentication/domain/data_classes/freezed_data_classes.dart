import 'package:freezed_annotation/freezed_annotation.dart';

part 'freezed_data_classes.freezed.dart';

@freezed
abstract class LoginObject with _$LoginObject {
  factory LoginObject(String email, String password) = _LoginObject;
}

@freezed
abstract class RegisterObject with _$RegisterObject {
  factory RegisterObject(
    String firstName,
    String lastName,
    String email,
    String password,
    String confirmPassword,
  ) = _RegisterObject;
}

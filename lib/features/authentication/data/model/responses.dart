import 'package:json_annotation/json_annotation.dart';

part 'responses.g.dart';

@JsonSerializable()
class BaseResponse {
  int? status;
  String? message;
}

@JsonSerializable()
class CustomerResponse {
  String? id;
  String? name;
  int? age;
  String? phone;

  CustomerResponse(this.id, this.name, this.age, this.phone);

  // from json
  factory CustomerResponse.fromJson(Map<String, dynamic> json) =>
      _$CustomerResponseFromJson(json);

  //to json
  Map<String, dynamic> toJson() => _$CustomerResponseToJson(this);
}

@JsonSerializable()
class AuthenticationResponse extends BaseResponse {
  CustomerResponse? customer;

  AuthenticationResponse(this.customer);

  //from Json
  factory AuthenticationResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationResponseFromJson(json);

  //to Json
  Map<String, dynamic> toJson() => _$AuthenticationResponseToJson(this);
}

@JsonSerializable()
class ResetPasswordResponse extends BaseResponse {
  String support;
  String contactUs;

  ResetPasswordResponse(this.support, this.contactUs);

  // from json
  factory ResetPasswordResponse.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordResponseFromJson(json);

  // to json
  Map<String, dynamic> toJson() => _$ResetPasswordResponseToJson(this);
}

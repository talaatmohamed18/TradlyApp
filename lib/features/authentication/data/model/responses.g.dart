// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: unused_element

part of 'responses.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponse _$BaseResponseFromJson(Map<String, dynamic> json) => BaseResponse()
  ..status = (json['status'] as num?)?.toInt()
  ..message = json['message'] as String?;

Map<String, dynamic> _$BaseResponseToJson(BaseResponse instance) =>
    <String, dynamic>{'status': instance.status, 'message': instance.message};

CustomerResponse _$CustomerResponseFromJson(Map<String, dynamic> json) =>
    CustomerResponse(
      json['id'] as String?,
      json['name'] as String?,
      (json['age'] as num?)?.toInt(),
      json['phone'] as String?,
    );

Map<String, dynamic> _$CustomerResponseToJson(CustomerResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'age': instance.age,
      'phone': instance.phone,
    };

AuthenticationResponse _$AuthenticationResponseFromJson(
  Map<String, dynamic> json,
) =>
    AuthenticationResponse(
        json['customer'] == null
            ? null
            : CustomerResponse.fromJson(
                json['customer'] as Map<String, dynamic>,
              ),
      )
      ..status = (json['status'] as num?)?.toInt()
      ..message = json['message'] as String?;

Map<String, dynamic> _$AuthenticationResponseToJson(
  AuthenticationResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'customer': instance.customer,
};

ResetPasswordResponse _$ResetPasswordResponseFromJson(
  Map<String, dynamic> json,
) =>
    ResetPasswordResponse(
        json['support'] as String,
        json['contactUs'] as String,
      )
      ..status = (json['status'] as num?)?.toInt()
      ..message = json['message'] as String?;

Map<String, dynamic> _$ResetPasswordResponseToJson(
  ResetPasswordResponse instance,
) => <String, dynamic>{
  'status': instance.status,
  'message': instance.message,
  'support': instance.support,
  'contactUs': instance.contactUs,
};

import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:tradly/core/error/failure.dart';
import 'package:tradly/core/resourcses/strings_manager.dart';

class ErrorHandler implements Exception {
  late Failure failure;

  ErrorHandler.handle(dynamic error) {
    if (error is DioException) {
      //DioError => DioException
      // Dio error so its an error from response of the API or from dio itself
      failure = _handleError(error);
    } else {
      //default
      failure = DataSource.defaultObject.getFailure();
    }
  }
}

Failure _handleError(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
      return DataSource.connectTimeout.getFailure();
    case DioExceptionType.sendTimeout:
      return DataSource.sendTimeout.getFailure();
    case DioExceptionType.receiveTimeout:
      return DataSource.recieveTimeout.getFailure();
    case DioExceptionType.badResponse:
      return DataSource.badRequest.getFailure();
    case DioExceptionType.cancel:
      return DataSource.cancel.getFailure();
    case DioExceptionType.unknown:
      return DataSource.defaultObject.getFailure();
    case DioExceptionType.badCertificate:
      return DataSource.badRequest.getFailure();
    case DioExceptionType.connectionError:
      return DataSource.noInternetConnection.getFailure();
    case DioExceptionType.transformTimeout:
      return DataSource.recieveTimeout.getFailure();
  }
}

enum DataSource {
  success,
  noContent,
  badRequest,
  unauthorized,
  forbidden,
  notFound,
  connectTimeout,
  internalServerError,
  cancel,
  sendTimeout,
  recieveTimeout,
  noInternetConnection,
  cacheError,
  defaultObject,
}

extension DataSourceExtension on DataSource {
  Failure getFailure() {
    switch (this) {
      case DataSource.success:
        return Failure(ResponseCode.success, ResponseMessage.success.tr());
      case DataSource.noContent:
        return Failure(ResponseCode.noContent, ResponseMessage.noContent.tr());
      case DataSource.badRequest:
        return Failure(
          ResponseCode.badRequest,
          ResponseMessage.badRequest.tr(),
        );
      case DataSource.unauthorized:
        return Failure(
          ResponseCode.unauthorized,
          ResponseMessage.unauthorized.tr(),
        );
      case DataSource.forbidden:
        return Failure(ResponseCode.forbidden, ResponseMessage.forbidden.tr());
      case DataSource.notFound:
        return Failure(ResponseCode.notFound, ResponseMessage.notFound.tr());
      case DataSource.connectTimeout:
        return Failure(
          ResponseCode.connectTimeout,
          ResponseMessage.connectTimeout.tr(),
        );
      case DataSource.internalServerError:
        return Failure(
          ResponseCode.internalServerError,
          ResponseMessage.internalServerError.tr(),
        );
      case DataSource.cancel:
        return Failure(ResponseCode.cancel, ResponseMessage.cancel.tr());
      case DataSource.sendTimeout:
        return Failure(
          ResponseCode.sendTimeout,
          ResponseMessage.sendTimeout.tr(),
        );
      case DataSource.recieveTimeout:
        return Failure(
          ResponseCode.recieveTimeout,
          ResponseMessage.recieveTimeout.tr(),
        );
      case DataSource.noInternetConnection:
        return Failure(
          ResponseCode.noInternetConnection,
          ResponseMessage.noInternetConnection.tr(),
        );
      case DataSource.defaultObject:
        return Failure(
          ResponseCode.defaultObject,
          ResponseMessage.defaultObject.tr(),
        );
      case DataSource.cacheError:
        return Failure(
          ResponseCode.cacheError,
          ResponseMessage.cacheError.tr(),
        );
    }
  }
}

class ResponseCode {
  static const int success = 200; // success with data
  static const int noContent = 204; // success with no data (no content)
  static const int badRequest = 400; // failure, API rejected request
  static const int unauthorized = 401; // failure, user is not authoraized
  static const int forbidden = 403; // failure, API rejected request
  static const int internalServerError = 500; // failure, crash in server side
  static const int notFound = 404; // failure, Not found

  //local status code يعني موصلش لل api اتكنسل
  static const int connectTimeout = -1; //
  static const int cancel = -2; //
  static const int recieveTimeout = -3; //
  static const int sendTimeout = -4; //
  static const int cacheError = -5; //
  static const int noInternetConnection = -6; //
  static const int defaultObject = -7; //
}

class ResponseMessage {
  static const String success = AppStrings.success; // success with data
  static const String noContent =
      AppStrings.noContent; // success with no data (no content)
  static const String badRequest =
      AppStrings.badRequestError; // failure, API rejected request
  static const String unauthorized =
      AppStrings.unauthorizedError; // failure, user is not authoraized
  static const String forbidden =
      AppStrings.forbiddenError; // failure, API rejected request
  static const String internalServerError =
      AppStrings.internalServerError; // failure, crash in server side
  static const String notFound = AppStrings.notFoundError; // failure, Not found

  //local status code
  static const String connectTimeout = AppStrings.timeoutError;
  static const String cancel = AppStrings.cancel;
  static const String recieveTimeout = AppStrings.recieveTimeout;
  static const String sendTimeout = AppStrings.sendTimeout;
  static const String cacheError = AppStrings.cacheError;
  static const String noInternetConnection = AppStrings.noInternetError;
  static const String defaultObject = AppStrings.defaultObject;
}

class ApiInternalStatus {
  static const int success = 0;
  static const int failure = 1;
}

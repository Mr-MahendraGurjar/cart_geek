import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:cart_geek/app/services/api_urls.dart';

class ApiClient {
  final Dio _dio;

  ApiClient({Dio? dio})
      : _dio = dio ??
            Dio(BaseOptions(
                baseUrl: ApiUrls.baseUrl,
                connectTimeout: const Duration(seconds: 5),
                receiveTimeout: const Duration(seconds: 3),
                headers: {'Content-Type': 'application/json'})) {
    _dio.interceptors.add(PrettyDioLogger());
  }

  Future<T> get<T>(
    String endpoint, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response.data as T;
    } catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return TimeoutException('Connection timed out');
        case DioExceptionType.badResponse:
          return BadResponseException(
            'Bad response: ${error.response?.statusCode}',
            statusCode: error.response?.statusCode,
          );
        case DioExceptionType.cancel:
          return RequestCancelledException('Request was cancelled');
        default:
          return NetworkException('Network error occurred');
      }
    }
    return UnknownException('An unknown error occurred');
  }
}

class TimeoutException implements Exception {
  final String message;

  TimeoutException(this.message);
}

class BadResponseException implements Exception {
  final String message;
  final int? statusCode;

  BadResponseException(this.message, {this.statusCode});
}

class RequestCancelledException implements Exception {
  final String message;

  RequestCancelledException(this.message);
}

class NetworkException implements Exception {
  final String message;

  NetworkException(this.message);
}

class UnknownException implements Exception {
  final String message;

  UnknownException(this.message);
}

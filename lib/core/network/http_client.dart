import 'package:dio/dio.dart';

class HttpClient {
  HttpClient() : dio = Dio() {
    dio.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['Authorization'] = _token == null ? null : 'Bearer $_token';
          options.headers['X-Tenant'] = _tenantId;
          options.headers['X-Active-Student-Id'] = _activeStudentId;
          handler.next(options);
        },
      ),
      LogInterceptor(requestBody: true, responseBody: true),
    ]);
  }

  final Dio dio;
  String? _token;
  String? _tenantId;
  String? _activeStudentId;

  void updateSession({String? token, String? tenantId, String? activeStudentId}) {
    _token = token ?? _token;
    _tenantId = tenantId ?? _tenantId;
    _activeStudentId = activeStudentId ?? _activeStudentId;
  }
}

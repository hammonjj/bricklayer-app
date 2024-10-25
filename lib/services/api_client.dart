import 'dart:async';
import 'dart:io' as io;

import 'package:bricklayer/services/app_settings.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class ApiClient {
  late Dio _dio;
  final String _urlBase;
  final AppSettings _appSettings;

  final defaultHeaders = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  final formHeaders = {
    'Content-Type': 'application/x-www-form-urlencoded',
    'Accept': 'application/json',
  };

  ApiClient({
    required String urlBase,
    required String environment,
    required AppSettings appSettings,
  })  : _urlBase = urlBase,
        _appSettings = appSettings {
    _dio = _createDioClient(environment);
  }

  Future<Response> post(String route, bool includeToken,
      {Map<String, dynamic>? data,
      Map<String, String>? headers,
      Map<String, dynamic>? queryParams,
      bool useFormHeaders = false}) async {
    final url = '$_urlBase$route';

    final combinedHeaders = {
      if (useFormHeaders) ...formHeaders else ...defaultHeaders,
      if (includeToken) ..._getTokenHeader(),
      if (headers != null) ...headers,
    };

    final response = await _dio.post(
      url,
      options: Options(headers: combinedHeaders),
      queryParameters: queryParams,
      data: data,
    );

    return response;
  }

  Future<Response> delete(String route, bool includeToken, {Map<String, String>? headers}) async {
    final url = '$_urlBase$route';

    final combinedHeaders = {
      ...defaultHeaders,
      if (includeToken) ..._getTokenHeader(),
      if (headers != null) ...headers,
    };

    final response = await _dio.delete(
      url,
      options: Options(headers: combinedHeaders),
    );

    return response;
  }

  Future<Response> get(String route, bool includeToken,
      {Map<String, String>? headers, Map<String, dynamic>? queryParameters, Object? body}) async {
    final url = '$_urlBase$route';

    final combinedHeaders = {
      ...defaultHeaders,
      if (includeToken) ..._getTokenHeader(),
      if (headers != null) ...headers,
    };

    final response = await _dio.get(
      url,
      options: Options(headers: combinedHeaders),
      queryParameters: queryParameters,
      data: body,
    );

    return response;
  }

  Future<Response> put(String route, bool includeToken, {Map<String, String>? headers, Object? body}) async {
    final url = '$_urlBase$route';

    final combinedHeaders = {
      ...defaultHeaders,
      if (includeToken) ..._getTokenHeader(),
      if (headers != null) ...headers,
    };

    final response = await _dio.put(
      url,
      options: Options(headers: combinedHeaders),
      data: body,
    );
    return response;
  }

  Dio _createDioClient(String environment) {
    final dio = Dio(BaseOptions(validateStatus: (status) {
      return status! < 500;
    }));

    if (environment == 'local') {
      dio.httpClientAdapter = IOHttpClientAdapter(createHttpClient: () {
        final client = io.HttpClient();
        client.badCertificateCallback = (io.X509Certificate cert, String host, int port) => true;
        return client;
      });
    }

    return dio;
  }

  Map<String, String> _getTokenHeader() {
    return {'Authorization': 'Bearer ${_appSettings.getToken()}'};
  }
}

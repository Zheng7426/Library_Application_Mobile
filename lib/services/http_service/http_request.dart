import 'package:library_application_mobile/shared/globals.dart' as globals;
import 'package:library_application_mobile/shared/loading.dart';
import 'package:library_application_mobile/services/connectivity/dio_connectivity_request_retrier.dart';
import 'package:library_application_mobile/services/connectivity/retry_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:connectivity/connectivity.dart';

class HttpService {
  Dio _dio;
  Options _options = Options(
    followRedirects: false,
    validateStatus: (status) {
      return status < 600;
    },
  );

  Options addToken(Options options, String token) {
    options.headers["authorization"] = "token ${token}";
    return options;
  }

  HttpService() {
    _dio = Dio();
    _dio.interceptors.add(
      RetryOnConnectionChangeInterceptor(
        requestRetrier: DioConnectivityRequestRetrier(
          dio: _dio,
          connectivity: Connectivity(),
        ),
      ),
    );
  }

  Future<dynamic> httpRequest(String reqType, String hostName,
      {Map<String, dynamic> params = null, String token = null}) async {
    Response _res;
    Options options = _options;
    if (token != null) {
      options = addToken(options, token);
    }
    switch (reqType) {
      case "POST":
        (params != null)
            ? _res = await _dio.post(hostName,
                queryParameters: params, options: options)
            : _res = await _dio.post(hostName, options: options);
        break;
      case "GET":
        (params != null)
            ? _res = await _dio.get(hostName,
                queryParameters: params, options: options)
            : _res = await _dio.get(hostName, options: options);
        break;
      case "PUT":
        (params != null)
            ? _res = await _dio.put(hostName,
            queryParameters: params, options: options)
            : _res = await _dio.put(hostName, options: options);
        break;
      case "PATCH":
        (params != null)
            ? _res = await _dio.patch(hostName,
            queryParameters: params, options: options)
            : _res = await _dio.patch(hostName, options: options);
        break;
      case "DELETE":
        (params != null)
            ? _res = await _dio.delete(hostName,
            queryParameters: params, options: options)
            : _res = await _dio.delete(hostName, options: options);
        break;
    }
    return _res.data;
  }
}

import 'package:library_application_mobile/shared/globals.dart' as globals;
import 'package:library_application_mobile/shared/loading.dart';
import 'package:library_application_mobile/services/connectivity/dio_connectivity_request_retrier.dart';
import 'package:library_application_mobile/services/connectivity/retry_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:connectivity/connectivity.dart';

class HttpService {
  Dio _dio;
  final Options _options = Options(
    followRedirects: false,
    validateStatus: (status) {
      return status < 600;
    },
  );

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

  Future<Map> httpRequest(
      String reqType, String hostName, Map<String, dynamic> params) async {
    Response _res;
    switch (reqType) {
      case "POST":
        _res = await _dio.post(hostName,
            queryParameters: params, options: _options);
        break;
      case "GET":
        _res = await _dio.get(hostName,
            queryParameters: params, options: _options);
        break;
      case "PUT":
        _res = await _dio.put(hostName,
            queryParameters: params, options: _options);
        break;
      case "PATCH":
        _res = await _dio.patch(hostName,
            queryParameters: params, options: _options);
        break;
      case "DELETE":
        _res = await _dio.delete(hostName,
            queryParameters: params, options: _options);
        break;
    }
    return _res.data;
  }
}

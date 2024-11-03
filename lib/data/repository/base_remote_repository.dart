import 'package:dio/dio.dart';

abstract class BaseRemoteRepository {
  const BaseRemoteRepository();
  // 여기는 반드시 자신의 사설 IP
  // windows -> cmd -> ipconfig
  // mac -> terminal -> ifconfig
  final host = 'http://192.168.219.102:8080';

  Dio get client => _client;

  String? get bearerToken => interceptor.bearerToken;

  static final interceptor = AuthInterceptor();

  static final Dio _client = Dio(
    BaseOptions(
      // 설정안할 시 실패 응답 시 throw
      validateStatus: (status) => true,
    ),
  )..interceptors.add(interceptor);
}

class AuthInterceptor extends Interceptor {
  AuthInterceptor();

  String? bearerToken;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    if (bearerToken != null) {
      print('REQUEST : $bearerToken');
      options.headers.addAll({'Authorization': bearerToken});
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');

    if (response.realUri.path == '/login' && response.statusCode == 200) {
      bearerToken = response.headers['Authorization']?.first;
    }
    super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    print(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    if (err.response == null) {
      return handler.resolve(Response(
        requestOptions: RequestOptions(),
      ));
    }
    return handler.resolve(err.response!);
  }
}

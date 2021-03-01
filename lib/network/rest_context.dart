import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import 'api_client.dart';

Logger _logger = Logger();
class RestContext {
  static const _API_KEY = "30aa1850dd4ab91e7bf6b08731f86934";
  static const THUMB_NAIL_PATH = "https://image.tmdb.org/t/p/w500/%s";
  static const POSTER_PATH = "https://image.tmdb.org/t/p/original/";

  static final RestContext _instance = RestContext._privateConstructor();
  RestContext._privateConstructor();
  factory RestContext() => _instance;

  ApiClient _apiClient;

  ApiClient get apiClient{
    if(_apiClient == null){
      Dio dio = _createDio();
      _apiClient = ApiClient(dio);
    }
    return _apiClient;
  }


  // Create Dio
  Dio _createDio() {
    var dio  =  Dio(
        BaseOptions(
            connectTimeout: 20000,
            receiveTimeout: 20000,
        )
    );

    addInterceptors(dio);
    return dio;
  }

  Dio addInterceptors(Dio dio) {
    return dio..interceptors.add(InterceptorsWrapper(
        onRequest: (RequestOptions options) => requestInterceptor(options),
        onResponse: (Response response) => responseInterceptor(response),
        onError: (DioError dioError) => errorInterceptor(dioError)));
  }

  dynamic requestInterceptor(RequestOptions options){
    options.queryParameters.addAll({"api_key": _API_KEY});
    _logger.i(options.data);
    return options;
  }

  dynamic responseInterceptor(Response response){
    if(response.statusCode == 200){
      _logger.i(response.data);
    }else{
      _logger.e("StatusCode -> ${response.statusCode} | StatusMessage -> ${response.statusMessage}");
    }

    return response;
  }

  dynamic errorInterceptor(DioError dioError){
    return dioError;
  }
}

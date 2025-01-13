import 'package:dio/dio.dart';
import 'package:sinda/models/collection.dart';

class DioEngine {
  late Dio _dio;
  init() {
    _dio = Dio();
  }

  run(HttpRequest req) async {
    Options options = Options(
      method: req.method.value,
      headers: req.headers,
    );

    return await _dio.request(req.url, options: options, data: req.body);
  }
}

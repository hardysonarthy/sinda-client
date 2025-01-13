import 'package:sinda/models/methods.dart';
import 'package:sinda/models/partial_index.dart';

class Collection extends PartialIndex {
  final int sortIndex;
  final String name;
  final List<HttpRequest> requests;

  Collection(this.sortIndex, this.name, this.requests) : super(sortIndex);
}

class HttpRequest extends PartialIndex {
  late int sortIndex;
  final Method method;
  final String url;
  final Map<String, dynamic>? headers;
  final Map<String, dynamic>? body;

  HttpRequest(
    this.method,
    this.url, {
    this.headers,
    this.body,
    this.sortIndex = 0,
  }) : super(sortIndex);
}

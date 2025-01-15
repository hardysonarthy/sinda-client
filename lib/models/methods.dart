import 'package:flutter/material.dart';
import 'package:sinda/constants/http_methods.dart';

class Method {
  final HttpMethods method;
  final String label;
  final String shortForm;
  final String value;
  final Color color;

  Method(this.method,
      {required this.label,
      required this.shortForm,
      required this.value,
      this.color = Colors.green});
}

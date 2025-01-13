import 'package:flutter/material.dart';
import 'package:sinda/constants/http_methods.dart';

class Method {
  final HttpMethods method;
  final String label;
  final String value;
  final Color color;

  Method(this.method, this.label, this.value, {this.color = Colors.green});

  getShortForm() {
    return label.substring(0, 3);
  }
}

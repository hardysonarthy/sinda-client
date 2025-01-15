import 'package:flutter/material.dart';
import 'package:sinda/models/methods.dart';

enum HttpMethods { get, post, put, patch, delete, head, options }

List<Method> httpMethods = [
  Method(HttpMethods.get,
      label: "GET", value: "GET", shortForm: "GET", color: Colors.green),
  Method(HttpMethods.post,
      label: "POST", value: "POST", shortForm: "POST", color: Colors.amber),
  Method(HttpMethods.put,
      label: "PUT", value: "PUT", shortForm: "PUT", color: Colors.blue),
  Method(HttpMethods.patch,
      label: "PATCH", value: "PATCH", shortForm: "PATCH", color: Colors.purple),
  Method(HttpMethods.delete,
      label: "DELETE", value: "DELETE", shortForm: "DEL", color: Colors.red),
  Method(HttpMethods.head,
      label: "HEAD", value: "HEAD", shortForm: "HEAD", color: Colors.green),
  Method(HttpMethods.options,
      label: "OPTIONS", value: "OPTIONS", shortForm: "OPT", color: Colors.pink),
];

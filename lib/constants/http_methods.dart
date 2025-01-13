import 'package:flutter/material.dart';
import 'package:sinda/models/methods.dart';

enum HttpMethods { get, post, put, patch, delete, head, options }

List<Method> httpMethods = [
  Method(HttpMethods.get, "GET", "GET", color: Colors.green),
  Method(HttpMethods.post, "POST", "POST", color: Colors.amber),
  Method(HttpMethods.put, "PUT", "PUT", color: Colors.blue),
  Method(HttpMethods.patch, "PATCH", "PATCH", color: Colors.purple),
  Method(HttpMethods.delete, "DELETE", "DELETE", color: Colors.red),
  Method(HttpMethods.head, "HEAD", "HEAD", color: Colors.green),
  Method(HttpMethods.options, "OPTIONS", "OPTIONS", color: Colors.pink),
];

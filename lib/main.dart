import 'package:flutter/material.dart';
import 'package:check_list_app/pages/home.dart';
import 'package:check_list_app/pages/details.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
      '/details': (context) => Details(),
    },
  ));
}


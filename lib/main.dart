import 'package:check_list_app/class/constants.dart';
import 'package:flutter/material.dart';
import 'package:check_list_app/pages/home.dart';
import 'package:check_list_app/pages/details.dart';
import 'package:hive/hive.dart';
import 'package:check_list_app/class/check_list_main.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final document = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(CheckListMainAdapter());
  final mainBox = await Hive.openBox(Constants.mainBox);
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
      '/details': (context) => Details(),
    },
  ));


}


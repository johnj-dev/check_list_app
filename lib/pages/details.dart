import 'package:flutter/material.dart';
import 'package:check_list_app/class/check_list_main.dart';
import 'package:check_list_app/class/check_list_details.dart';

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        title: Text(data['title']),
        centerTitle: true,
      ),
      body: Text('Details'),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Add new checklist
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}

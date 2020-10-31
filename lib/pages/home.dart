import 'package:flutter/material.dart';
import 'package:check_list_app/class/check_list_main.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<CheckListMain> main = [
    CheckListMain(title: 'CheckList 1'),
    CheckListMain(title: 'CheckList 2'),
    CheckListMain(title: 'CheckList 3'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Check List'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: main.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
            child: Card(
              child: ListTile(
                onTap: () {
                  // TODO: Next page for description
                  Navigator.pushNamed(context, '/details', arguments: {
                    'title': main[index].title
                  });
                },
                title: Text(main[index].title),
                trailing: IconButton(
                  onPressed: () {
                    // TODO: Place it into Archives
                  },
                  icon: Icon(Icons.delete),
                ),
              ),
            ),
          );
        },
      ),
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

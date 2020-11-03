import 'package:check_list_app/class/constants.dart';
import 'package:flutter/material.dart';
import 'package:check_list_app/class/check_list_main.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final TextEditingController titleCtrl = TextEditingController();

  List<CheckListMain> main = [
    CheckListMain(title: 'CheckList 1'),
    CheckListMain(title: 'CheckList 2'),
    CheckListMain(title: 'CheckList 3'),
  ];
  final mainBox = Hive.box(Constants.mainBox);

  void addNewList(CheckListMain checkListMain) {
    mainBox.add(checkListMain);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Check List'),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              // TODO : Filter
              switch (value) {
                case 'Incomplete':
                  break;
                case 'Complete':
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return ['All', 'Incomplete', 'Complete'].map((option) {
                return PopupMenuItem(
                  value: option,
                  child: Text(option),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: ValueListenableBuilder(
        valueListenable: mainBox.listenable(),
        builder: (context, mainBox, _) {
          return ListView.builder(
            itemCount: mainBox.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final mainList = mainBox.getAt(index) as CheckListMain;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
                child: Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.pushNamed(context, '/details', arguments: {
                        'title': mainList.title
                      });
                    },
                    title: Text(mainList.title),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check,
                          color: mainList.isCompleted ? Colors.green : Colors.red
                        ),
                        IconButton(
                          onPressed: () {
                            mainBox.deleteAt(index);
                          },
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Add new checklist
          showDialog(
            context: context,
            child: Dialog(
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Title'
                      ),
                      controller: titleCtrl,
                    ),
                    SizedBox(height: 5.0,),
                    RaisedButton(
                      onPressed: () {
                        final checkListMain = CheckListMain(title: titleCtrl.text, isCompleted: false);
                        addNewList(checkListMain);
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/details', arguments: {
                          'title': titleCtrl.text
                        });
                        titleCtrl.clear();
                      },
                      child: Text('Add'),
                    ),
                  ],
                )
              )
            )
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}

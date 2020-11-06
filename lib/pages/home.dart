import 'package:check_list_app/class/constants.dart';
import 'package:flutter/material.dart';
import 'package:check_list_app/class/check_list_main.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

enum FilterData {ALL, INCOMPLETE, COMPLETE}

class _HomeState extends State<Home> {

  final TextEditingController titleCtrl = TextEditingController();

  final mainBox = Hive.box(Constants.mainBox);

  List<int> keys = List<int>();

  FilterData filter = FilterData.ALL;

  void addNewList(CheckListMain checkListMain){
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
              if (value.compareTo('All') == 0){
                setState(() {
                  filter = FilterData.ALL;
                });
              } else if (value.compareTo('Incomplete') == 0){
                setState(() {
                  filter = FilterData.INCOMPLETE;
                });
              } else {
                setState(() {
                  filter = FilterData.COMPLETE;
                });
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

          if ( filter == FilterData.ALL ) {
            keys = mainBox.keys.cast<int>().toList();
          } else if ( filter == FilterData.INCOMPLETE ) {
            keys = mainBox.keys.cast<int>().where((key) => !mainBox.get(key).isCompleted).toList();
          } else {
            keys = mainBox.keys.cast<int>().where((key) => mainBox.get(key).isCompleted ? true : false).toList();
            print('test');
          }

          return ListView.builder(
            itemCount: keys.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final int key = keys[index];
              CheckListMain mainList = mainBox.get(key);
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
                child: Card(
                  child: ListTile(
                    onTap: () {
                      print(keys[index]);
                      Navigator.pushNamed(context, '/details', arguments: {
                        'checkListMain': mainBox.get(keys[index]),
                        'index': keys[index]
                      });
                    },
                    leading: Text(keys[index].toString()),
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
                            mainBox.delete(index);
                            keys = mainBox.keys.cast<int>().toList();
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
                        keys = mainBox.keys.cast<int>().toList();
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/details', arguments: {
                          'checkListMain': checkListMain,
                          'index': keys[keys.length - 1]
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

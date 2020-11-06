import 'package:flutter/material.dart';
import 'package:check_list_app/class/check_list_main.dart';
import 'package:check_list_app/class/check_list_details.dart';
import 'package:check_list_app/class/constants.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {

  Map data = {};
  final TextEditingController descriptionCtrl = TextEditingController();
  final mainBox = Hive.box(Constants.mainBox);
  int id = 0;



  bool isAllDone(CheckListMain checkListMain) {
    List<CheckListDetails> details = checkListMain.details;
    for (int i = 0; i < details.length; i++){
      if (details[i].isDone == false) {
        return false;
      }
    }
    return true;
  }

  void saveUpdates(CheckListMain checkListMain, int id) {
    checkListMain.isCompleted = isAllDone(checkListMain);
    mainBox.put(id, checkListMain);
  }


  @override
  Widget build(BuildContext context) {

    data = ModalRoute.of(context).settings.arguments;
    CheckListMain checkListMain = data['checkListMain'];
    id = data['index'];

    checkListMain.details = checkListMain.details != null ? checkListMain.details : List<CheckListDetails>();

    return Scaffold(
      appBar: AppBar(
        title: Text(checkListMain.title),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        valueListenable: mainBox.listenable(),
        builder: (context, mainBox, _) {
          return ListView.builder(
            itemCount: checkListMain.details.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
                child: Card(
                  child: ListTile(
                    onTap: () {
                      checkListMain.details[index].isDone =
                          checkListMain.details[index].isDone ? false : true;
                      saveUpdates(checkListMain, id);
                    },
                    title: Text(checkListMain.details[index].description),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                            Icons.check,
                            color: checkListMain.details[index].isDone ? Colors.green : Colors.red
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
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Description'
                      ),
                      controller: descriptionCtrl,
                    ),
                    SizedBox(height: 5.0,),
                    RaisedButton(
                      onPressed: () {
                        checkListMain.details.add(CheckListDetails(description: descriptionCtrl.text, isDone: false));
                        saveUpdates(checkListMain, id);
                        Navigator.pop(context);
                      },
                      child: Text('Add'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}

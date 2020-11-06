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
  List<CheckListDetails> detailsList;
  int id = 0;

  @override
  Widget build(BuildContext context) {

    data = ModalRoute.of(context).settings.arguments;
    CheckListMain checkListMain = data['checkListMain'];
    id = data['index'];

    checkListMain.details = List<CheckListDetails>();

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
              final mainList = mainBox.getAt(id) as CheckListMain;
              detailsList = mainList.details;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 1.0, horizontal: 4.0),
                child: Card(
                  child: ListTile(
                    onTap: () {

                    },
                    title: Text(detailsList[index].description),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                            Icons.check,
                            color: detailsList[index].isDone ? Colors.green : Colors.red
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
                        try{
                          checkListMain.details.add(CheckListDetails(description: descriptionCtrl.text, isDone: false));
                          mainBox.putAt(id, checkListMain);
                        } catch (e) {
                          print(e.toString());
                        }
                        // checkListMain.details.add(CheckListDetails(description: descriptionCtrl.text, isDone: false));
                        // mainBox.putAt(id, checkListMain);
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

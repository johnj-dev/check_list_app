import 'package:check_list_app/class/check_list_details.dart';
import 'package:hive/hive.dart';

part 'check_list_main.g.dart';

@HiveType(typeId: 0)
class CheckListMain {

  @HiveField(0)
  String title;
  @HiveField(1)
  bool isCompleted;
  @HiveField(2)
  List<CheckListDetails> details;

  CheckListMain({ this.title });

  void getDetails() {
// test
  }

  void updateArchived(bool) {
    this.isCompleted = bool;
  }

}
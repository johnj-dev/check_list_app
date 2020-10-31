import 'package:check_list_app/class/check_list_details.dart';

class CheckListMain {

  String title;
  bool isArchived;
  List<CheckListDetails> details;

  CheckListMain({ this.title });

  void getDetails() {

  }

  void updateArchived(bool) {
    this.isArchived = bool;
  }

}
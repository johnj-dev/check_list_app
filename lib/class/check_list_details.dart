import 'package:hive/hive.dart';

part 'check_list_details.g.dart';

@HiveType(typeId: 1)
class CheckListDetails {

  @HiveField(0)
  String description;
  @HiveField(1)
  bool isDone;

  CheckListDetails({ this.description, this.isDone });

}
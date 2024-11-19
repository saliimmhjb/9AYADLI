import 'package:hive/hive.dart';

class toDoDatabase {
  List toDoList = [];

  final _myBox = Hive.box("myBox");

  void createIntialData()
  {
    toDoList = [
      ["DOWNLOAD 9AYADL! APP", true],
    ];
  }

  void loadData()
  {
    toDoList = _myBox.get("TODOLIST");

  }

  void updateData()
  {
    _myBox.put("TODOLIST", toDoList);
  }
}
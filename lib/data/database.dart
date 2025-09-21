import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  //list to store all todos and their status
  List toDolist = [];

  //reference our box
  final _mybox = Hive.box('mybox');

  //run this method if this is the first time opening this app
  void createInitialData() {
    toDolist = [
      ["My First To-Do", false],
    ];
  }

  //run this method to store a To-Do
  void storeData() {
    toDolist = _mybox.get("TODOLIST");
  }

  //run this method to update a To-Do
  void updateDatabase() {
    _mybox.put("TODOLIST",toDolist);
  }
}

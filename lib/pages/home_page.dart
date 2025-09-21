import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:to_do_app/data/database.dart';
import 'package:to_do_app/utilities/create_new_task.dart';
import 'package:to_do_app/utilities/todotile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //reference the Hive box
  final _mybox = Hive.box('mybox');

  //initial State
  @override
  void initState() {
    //if this is the first time ever opening the app, then create default data
    if (_mybox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      //if there already exists data
      db.storeData();
    }
    super.initState();
  }

  //text controller
  final _controller = TextEditingController();

  //list of todo tasks
  ToDoDatabase db = ToDoDatabase();

  //checkbox was tapped
  void checkBoxChanged(bool? value, index) {
    setState(() {
      db.toDolist[index][1] = !db.toDolist[index][1];
    });
    db.updateDatabase();
  }

  //create a new task
  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return CreateNewTask(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop(),
        );
      },
    );
    db.updateDatabase();
  }

  //save the new task
  void saveNewTask() {
    setState(() {
      db.toDolist.add([_controller.text, false]);
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  void deleteTask(int index) {
    setState(() {
      db.toDolist.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      backgroundColor: Colors.yellow[300],
      body: ListView.builder(
        itemCount: db.toDolist.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDolist[index][0],
            taskCompleted: db.toDolist[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add),
      ),
    );
  }
}

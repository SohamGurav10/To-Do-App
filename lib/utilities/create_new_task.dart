import 'package:flutter/material.dart';
import 'package:to_do_app/utilities/my_button.dart';

class CreateNewTask extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSave;
  final VoidCallback onCancel;
  const CreateNewTask({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.yellow[300],
      content: SizedBox(
        height: 200,
        width: 350,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            //get user input
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Add a new Task",
                border: OutlineInputBorder(),
              ),
            ),
            //buttons -> save + cancel
            Row(
              mainAxisAlignment: MainAxisAlignment.end,

              children: [
                MyButton(title: "Save", onPressed: onSave),
                const SizedBox(width: 10),
                MyButton(title: "Cancel", onPressed: onCancel),
              ],
            ),
          ],
        ),
      ),
      // actions: [
      //   MyButton(title: "Save", onPressed: onSave),
      //   MyButton(title: "Cancel", onPressed: onCancel),
      // ],
    );
  }
}

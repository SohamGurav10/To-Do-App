import 'package:flutter/material.dart';
import 'package:to_do_app/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  //initialise Hive
  await Hive.initFlutter();

  //Open a box (like a table in SQL)
  await Hive.openBox("mybox");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(title: 'TO-DO  LIST'),
      theme: ThemeData(primaryColor: Colors.yellow),
    );
  }
}

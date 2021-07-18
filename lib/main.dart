import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game/page/page.dart';


void main() {

  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: MyHomePage(title: 'Game'),
    );
  }
}














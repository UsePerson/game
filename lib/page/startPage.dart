import 'package:flutter/material.dart';
import 'package:game/page/sudokuPage.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  void _sudokuPushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute(
          builder: (_) => SudokuPage('Sudoku')
      ),
    );
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: _sudokuPushSaved,
              child: Text('Sudoku',
                  style: TextStyle(
                    fontSize: 40,
                  )),
            ),
            TextButton(
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              ),
              onPressed: () { },
              child: Text(
                  'coming soon',
                  style: TextStyle(
                    fontSize: 40,
                  )
              ),
            ),
          ],
        ),
      ),
    );
  }
}
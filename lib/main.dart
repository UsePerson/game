import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Game'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
              onPressed: () {},
              child: Text('coming soon',
                  style: TextStyle(
                    fontSize: 40,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void _sudokuPushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => SudokuPage('Sudoku')),
    );
  }
}

class SudokuPage extends StatelessWidget {
  final String title;
  SudokuPage(this.title);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: GestureDetector(
        // onTap: () => ,
        child: Center(child: Text("SudokuBoard")),
      ),
    );
  }
}

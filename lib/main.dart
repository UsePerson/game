import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



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
        // onTap: ()
        child: Column(
          children: [
            TimerBlock(),
            SudokuBoard(),
          ],
        ),
      ),
    );
  }
}
class TimerBlock extends StatefulWidget{

  @override
  _TimerCounter createState() => new _TimerCounter();
}

class _TimerCounter extends State<TimerBlock>{

  static const duration = const Duration(seconds: 1);
  int time = 0;
  bool stopTimer = true;
  Timer? _timer ;
  void stopTime(){
    if(!stopTimer){
      setState(() {
        time += 1;
      });
    }
  }
  String changeStopText(){

    if(stopTimer){
      return "start";
    }
    return "stop";
  }
  @override
  void initState() {
    _timer = Timer.periodic(duration, (timer) {
      stopTime();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // if(_timer == null)
    //   _timer = Timer.periodic(duration, (timer) {
    //     stopTime();
    //   });
    int seconds = time % 60;
    int minutes = time %(60*60) ~/ 60;
    int hours = time ~/ (60 * 60);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
              "  " + hours.toString().padLeft(2, '0') + " : ",
              style: TextStyle(fontSize: 30),
        ),
        Text(
            minutes.toString().padLeft(2, '0') + " : ",
            style: TextStyle(fontSize: 30),
        ),
        Text(
            seconds.toString().padLeft(2, '0') + "  ",
            style: TextStyle(fontSize: 30),
        ),
        Container(
          child: ElevatedButton(
            child: Text(
                changeStopText(),
            ),
            onPressed: (){

              setState(() {
                stopTimer = !stopTimer;
              });
            },
          ),
        ),
      ],
    );
  }
}

class SudokuBoard extends StatelessWidget{

  double defaultWidth(BuildContext context){
    double height = MediaQuery.of(context).size.height ;
    height = ( height >= 200.0) ? (height - 200.0) / 9  : height / 9 ;
    double width = (MediaQuery.of(context).size.width) / 9;
    return (width < height/2) ? width : min(height, width);
  }
  @override
  Widget build(BuildContext context){

    return Table(
      defaultColumnWidth: FixedColumnWidth(defaultWidth(context)),
      border: TableBorder(
        left: BorderSide(width: 3.0, color: Colors.black),
        top: BorderSide(width: 3.0, color: Colors.black),
      ),
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      children: _getTableRows(),
    );
  }
  List<TableRow> _getTableRows(){

    return List.generate(
        9, (rowNumber) => TableRow(children: _getRow(rowNumber))
      );
    }
  List<Widget> _getRow(int rowNumber){

    return List.generate(9, (int colNumber) {
      return Container(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              width: (colNumber % 3 == 2) ? 3.0 : 1.0,
              color: Colors.black,
            ),
            bottom: BorderSide(
              width: (rowNumber % 3 == 2) ? 3.0 : 1.0,
              color: Colors.black,
            ),
          ),
        ),
        child: SudokuCell(rowNumber, colNumber),
      );
    });
  }
}

class SudokuCell extends StatelessWidget{

  final int row, col;
  SudokuCell(this.row, this.col);

  double blockSize(BuildContext context){

    double height = (MediaQuery.of(context).size.height - 200.0) /9;
    double width = (MediaQuery.of(context).size.width) / 9;

    return (width < height/2) ? width : min(height, width);
  }
  @override
  Widget build(BuildContext context){
    return InkResponse(
      enableFeedback: true,
      onTap: (){
        debugPrint('($row, $col) ');
        debugPrint(blockSize(context).toString());
        debugPrint(MediaQuery.of(context).size.width.toString());
      },
      child: SizedBox(
        width: blockSize(context),
        height: blockSize(context),
        child: Container(
          child: Center(
            child: Text(''),
          ),
        ),
      ),
    );
  }
}





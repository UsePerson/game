import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game/utility/sudokuCellState.dart';
import 'package:scoped_model/scoped_model.dart';

class TimerBlock extends StatefulWidget{

  @override
  _TimerCounter createState() => new _TimerCounter();
}

class _TimerCounter extends State<TimerBlock>{

  static const duration = const Duration(seconds: 1);
  int time = 0;
  bool stopTimer = false;
  Timer? _timer ;
  void counterTime(){
    if(!stopTimer){
      setState(() {
        time += 1;
      });
    }
  }
  String changeButtonText(){

    if(stopTimer){
      return "start";
    }
    return "stop";
  }
  bool endGame(CellStateList model){
    if((model.error == 3) || (model.correct==81))
      return true;
    return false;
  }
  @override
  void initState() {
    _timer = Timer.periodic(duration, (timer) {
      counterTime();
    });
    super.initState();
  }
  @override
  void dispose() {
    _timer?.cancel();
    _timer = null;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    int seconds = time % 60;
    int minutes = time %(60*60) ~/ 60;
    int hours = time ~/ (60 * 60);

    return ScopedModelDescendant<CellStateList>(builder: (context, child, model){
      if(endGame(model))
        stopTimer = true;
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "  " + hours.toString().padLeft(2, '0') + " : ",
            style: TextStyle(fontSize: 30),
          ),
          Text(
            minutes.toString().padLeft(2, '0') + " : ",
            style: TextStyle(fontSize: 28),
          ),
          Text(
            seconds.toString().padLeft(2, '0') + "  ",
            style: TextStyle(fontSize: 28),
          ),
          if(!endGame(model))
            Container(
              child: ElevatedButton(
                child: Text(
                  changeButtonText(),
                ),
                onPressed: () {
                  setState(() {
                    stopTimer = !stopTimer;
                    model.setStop();
                  });
                },
              ),
            ),

          Text(
            "  ERROR: " + model.error.toString() + "/" + "3",
            style: TextStyle(fontSize: 28),
          )
        ],
      );
    });
  }
}
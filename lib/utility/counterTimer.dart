import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimerBlock extends StatefulWidget{

  @override
  _TimerCounter createState() => new _TimerCounter();
}

class _TimerCounter extends State<TimerBlock>{

  static const duration = const Duration(seconds: 1);
  int time = 0;
  bool stopTimer = true;
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
  @override
  void initState() {
    _timer = Timer.periodic(duration, (timer) {
      counterTime();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

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
              changeButtonText(),
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
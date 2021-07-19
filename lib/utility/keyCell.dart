import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game/utility/sudokuCellState.dart';
import 'package:scoped_model/scoped_model.dart';

class KeyCell extends StatefulWidget{

  final int? row, col;
  KeyCell(this.row, this.col);
  @override
  _KeyCell createState() => new _KeyCell(row!, col!);
}

class _KeyCell extends State<KeyCell>{

  int row, col;
  _KeyCell(this.row, this.col);

  double blockSize(BuildContext context){

    double height = (MediaQuery.of(context).size.height - 200.0) /9;
    double width = (MediaQuery.of(context).size.width) / 9;

    return (width < height/2) ? width : min(height, width);
  }

  @override
  Widget build(BuildContext context){
    return  ScopedModelDescendant<CellStateList>(builder: (context, child, model) {
      return InkResponse(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        radius: 0.0,
        enableFeedback: true,
        onTap: () {
          setState(() {
            for(int i = 0 ; i < 9 ; i ++ ){

              (i == col)
                  ? model.setKeyColor(i, Colors.black12)
                  : model.setKeyColor(i, Colors.white);
            }
            model.setUserVal(model.row, model.col, (col+1).toString());
          });
        },
        child: SizedBox(
          width: blockSize(context),
          height: blockSize(context),
          child: Container(
            color: model.getKeyColor(col),
            child: Center(
                child: Text((col+1).toString(), style: TextStyle(color: Colors.black, fontSize: 25),)
            ),
          ),
        ),
      );
    });
  }
}
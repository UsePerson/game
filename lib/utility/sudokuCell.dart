import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game/utility/sudokuCellState.dart';
import 'package:scoped_model/scoped_model.dart';


class SudokuCell extends StatefulWidget{

  final int? row, col;
  SudokuCell(this.row, this.col);
  @override
  _SudokuCell createState() => new _SudokuCell(row!, col!);
}

class _SudokuCell extends State<SudokuCell>{

  int row, col;
  _SudokuCell(this.row, this.col);

  String checkValue(String input){
    if(input == "0")
      return "";
    return input;
  }
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
            model.setRow(row);
            model.setCol(col);
            for (int r = 0; r < 9; r ++) {

              for (int c = 0; c < 9; c ++) {

                if(r == row && c == col){
                  model.setBackgroundColor(r, c, Colors.lightBlueAccent);
                }
                else if (r == row || c == col) {
                  model.setBackgroundColor(r, c, Color(0XFF6FD5FF));
                }
                else
                  model.setBackgroundColor(r, c, Colors.white);

                (model.getUserVal(r, c) == model.getUserVal(row, col))
                ? model.setTextColor(r, c, Color(0xFF8457EF))
                : model.setTextColor(r, c, Colors.black);

                if( (model.getUserVal(r, c) != "0") && (model.getUserVal(r, c) != model.getAnsVal(r, c)))
                  model.setTextColor(r, c, Colors.red);
              }
            }
          });
        },
        child: SizedBox(
          width: blockSize(context),
          height: blockSize(context),
          child: Container(
            color: model.getBackgroundColor(row, col),
            child: Center(
              child: Text(checkValue(model.getUserVal(row, col)), style: TextStyle(color: model.getTextColor(row, col), fontSize: 25),)
            ),
          ),
        ),
      );
    });
  }
}
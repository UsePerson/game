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
// maybe InheritedWidget is good guys
// scoped_model
class _SudokuCell extends State<SudokuCell>{

  int row, col;
  _SudokuCell(this.row, this.col);

  String num = "0";
  Color color = Colors.white;

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
        enableFeedback: true,
        onTap: () {
          setState(() {
            model.setRow(row);
            model.setCol(col);

            for (int r = 0; r < 9; r ++) {
              for (int c = 0; c < 9; c ++) {

                if(r == row && c == col){
                  model.setColor(r, c, Colors.lightBlueAccent);
                }
                else if (r == row || c == col) {
                  model.setColor(r, c, Color(0XFF6FD5FF));
                }
                else
                  model.setColor(r, c, Colors.white);
              }
            }
          });
        },
        child: SizedBox(
          width: blockSize(context),
          height: blockSize(context),
          child: Container(
            color: model.getColor(row, col),
            child: Center(
              child: Text(checkValue(model.getUserVal(row, col)))
            ),
          ),
        ),
      );
    });
  }
}
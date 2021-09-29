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
  void checkUserAns(CellStateList model){
    if((model.getAnsVal(model.row, model.col) != (col+1).toString()) && (model.getAnsVal(model.row, model.col) != model.getUserVal(model.row, model.col))) {
      model.incError();
    }
    else if(model.getAnsVal(model.row, model.col) != model.getUserVal(model.row, model.col)){

      model.incCorrect();
      model.incKeyNumber(col+1);

    }
  }
  void setUserAns(CellStateList model){

    checkUserAns(model);
    if(model.getAnsVal(model.row, model.col) != model.getUserVal(model.row, model.col))
      model.setUserVal(model.row, model.col, (col+1).toString());
  }
  void changeTextColor(CellStateList model, int r, int c){
    (model.getUserVal(r, c) == (col+1).toString())
        ? model.setTextColor(r, c, Color(0xFF8457EF))
        : model.setTextColor(r, c, Colors.black);
    if(model.getAnsVal(r, c) != model.getUserVal(r, c))
      model.setTextColor(r, c, Colors.red);
  }
  void highlightKeyColor(CellStateList model, int r){
    (r == col)
        ? model.setKeyColor(r, Colors.black12)
        : model.setKeyColor(r, Colors.white);
  }

  @override
  Widget build(BuildContext context){
    return  ScopedModelDescendant<CellStateList>(builder: (context, child, model) {
      if(model.stop)
        return InkResponse(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          radius: 0.0,
          enableFeedback: true,
          child: SizedBox(
            width: blockSize(context),
            height: blockSize(context),
          ),
        );
      else
        return InkResponse(
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
          radius: 0.0,
          enableFeedback: true,
          onTap: () {
            setState(() {

              if(model.getKeyBoard(col+1) != "9"){

                setUserAns(model); // if user ans is not correct, set red and add incorrect times
                for(int r = 0 ; r < 9 ; r ++ ){

                  for(int c = 0 ; c < 9 ; c ++){

                    changeTextColor(model, r, c); // same number become to another color
                  }
                  highlightKeyColor(model, r);
                }
                if(model.getKeyBoard(col+1) == "9")
                  model.setKeyColor(col, Colors.white);
              }
            });
          },
          child: SizedBox(
            width: blockSize(context),
            height: blockSize(context),
            child: Container(
              color: model.getKeyBoardColor(col),
              child: Center(
                  child:
                  Text(
                    (model.getKeyBoard(col+1) != "9")
                      ?(col+1).toString()
                      : " ", 
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  )
              ),
            ),
          ),
        );
    });
  }
}
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game/page/sudokuPage.dart';
import 'package:game/utility/sudokuCellState.dart';
import 'package:scoped_model/scoped_model.dart';
import 'keyCell.dart';

class KeyBoard extends StatelessWidget{

  double defaultWidth(BuildContext context){
    double height = MediaQuery.of(context).size.height ;
    height = ( height >= 200.0) ? (height - 200.0) / 9  : height / 9 ;
    double width = (MediaQuery.of(context).size.width) / 9;
    return (width < height/2) ? width : min(height, width);
  }
  List<TableRow> _getTableRows(){

    return List.generate(
        1, (rowNumber) => TableRow(children: _getRow(rowNumber))
    );
  }
  List<Widget> _getRow(int rowNumber){

    return List.generate(9, (int colNumber) {
      return Container(
        decoration: BoxDecoration(
          border: Border(
            right: BorderSide(
              width: (colNumber % 3 == 2) ? 3.0 : 1.0,
              color: Colors.white,
            ),
            bottom: BorderSide(
              width: (rowNumber % 3 == 2) ? 3.0 : 1.0,
              color: Colors.white,
            ),
          ),
        ),
        child: KeyCell(rowNumber, colNumber),
      );
    });
  }
  @override
  Widget build(BuildContext context){
    return ScopedModelDescendant<CellStateList>(builder: (context, child, model){
      if(model.error == 3 || model.correct==81) // end Game state
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            (model.error == 3 )
                ? Text('You Lose!!!  ',style: TextStyle(fontSize: 30))
                : Text('You Win!!!  ',style: TextStyle(fontSize: 30)),
            Container(
              child: ElevatedButton(
                child:
                Text('Leave'),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              margin: EdgeInsets.only(left: 10,right: 10),
            ),
            Container(
              child: ElevatedButton(
                child: Text('Restart'),
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => new SudokuPage('Sudoku')));
                },
              ),
            ),
          ],
        );

      return Table(
          defaultColumnWidth: FixedColumnWidth(defaultWidth(context)),
          border: TableBorder(
            left: BorderSide(width: 3.0, color: Colors.white),
            top: BorderSide(width: 3.0, color: Colors.white),
          ),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,

          children: _getTableRows(),
        );
    });
  }
}

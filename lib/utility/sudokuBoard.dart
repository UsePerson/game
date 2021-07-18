import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game/utility/sudokuCell.dart';

class SudokuBoard extends StatelessWidget{

  double defaultWidth(BuildContext context){
    double height = MediaQuery.of(context).size.height ;
    height = ( height >= 200.0) ? (height - 200.0) / 9  : height / 9 ;
    double width = (MediaQuery.of(context).size.width) / 9;
    return (width < height/2) ? width : min(height, width);
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
}

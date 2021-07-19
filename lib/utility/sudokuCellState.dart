import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class CellState {

  Color _color = Colors.white;
  final String _ansVal;
  String _userVal = "0";

  CellState(this._color, this._ansVal, this._userVal);

  String getAnsVal(){

    return this._ansVal;
  }
  String getUserVal(){

    return this._userVal;
  }
  Color getColor(){

    return this._color;
  }
  void setUserVal(String input){

    this._userVal = input;
  }
  void setColor(Color input){

    this._color = input;
  }
}

class CellStateList extends Model{

  int _row = -1;
  int _col = -1;
  List<List<CellState>> _cSL =
    List.generate(9, (index) => List.generate(9, (index) => CellState(Colors.white, "3", "0")));

  List<Color> _keyBoardColor = List.generate(9, (index) => Colors.white);
  void setUserVal(int row, int col, String usrAns){
    _cSL[row][col].setUserVal(usrAns);
    notifyListeners();
  }
  void setColor(int row, int col, Color color){
    _cSL[row][col].setColor(color);
    notifyListeners();
  }
  void setKeyColor(int index, Color c){
      _keyBoardColor[index] = c;
      notifyListeners();
  }
  Color getKeyColor(int index){
    return _keyBoardColor[index];
  }
  String getUserVal(int row, int col){
    return _cSL[row][col].getUserVal();
  }
  Color getColor(int row, int col){
    return _cSL[row][col].getColor();
  }
  void removeUserVal(int row, int col, String usrAns){
    _cSL[row][col].setUserVal("0");
    notifyListeners();
  }

  int get row => _row;
  int get col => _col;

  void setRow(int value) {
    _row = value;
    notifyListeners();
  }

  void setCol(int value) {
    _col = value;
    notifyListeners();
  }
}
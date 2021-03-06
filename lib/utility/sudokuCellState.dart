import 'dart:math';
import 'package:flutter/material.dart';
import 'sudokuGenerator.dart';
import 'package:scoped_model/scoped_model.dart';

class CellState {

  Color _backgroundColor = Colors.white;
  Color _textColor = Colors.black;
  String _ansVal;
  String _userVal = "0";

  CellState(this._backgroundColor, this._textColor, this._ansVal, this._userVal);

  String getAnsVal(){

    return this._ansVal;
  }
  String getUserVal(){

    return this._userVal;
  }
  Color getBackgroundColor(){

    return this._backgroundColor;
  }
  Color getTextColor(){
    return this._textColor;
  }

  void setAnsVal(String input){

    this._ansVal = input;
  }
  void setUserVal(String input){

    this._userVal = input;
  }
  void setBackgroundColor(Color input){

    this._backgroundColor = input;
  }
  void setTextColor(Color input){
    this._textColor = input;
  }

}

class CellStateList extends Model{

  int _row = -1;
  int _col = -1;
  int _error = 0;
  int _correct = 0;
  bool _stop = false;
  SudokuGenerator _generator = new SudokuGenerator();
  var rand = new Random();


  List<List<CellState>> _cSL = List.generate(9, (r) => List.generate(9, (c) =>
      CellState(Colors.white, Colors.black, "1", "2")));

  List<Color> _keyBoardColor = List.generate(9, (index) => Colors.white);
  List<int> _keyBoard = List.generate(10, (index) => 0);
  CellStateList(){

    int ra = rand.nextInt(65)+15;

    _generator.fillDiagonal();
    _generator.fillRemaining(0, 3);

    initAns();
    _generator.removeKDigits(ra);
    initUserAns();
  }
  void initAns(){
    for(int r = 0 ; r < 9 ;r ++ ){
      for(int c = 0 ; c < 9 ;c ++){
        _cSL[r][c].setAnsVal(_generator.getBoard(r, c).toString());
      }
    }
  }
  void initUserAns(){
    for(int r = 0 ; r < 9 ;r ++ ){
      for(int c = 0 ; c < 9 ;c ++){
        _cSL[r][c].setUserVal(_generator.getBoard(r, c).toString());
        if (_cSL[r][c].getUserVal() != "0")
          _correct++;
        _keyBoard[int.parse(_cSL[r][c].getUserVal())]++;
      }
    }
  }

  void incError(){
    this._error ++;
    notifyListeners();
  }
  void incCorrect(){
    this._correct++;
  }
  void incKeyNumber(int position){
    _keyBoard[position]++;
    notifyListeners();
  }

  void setAnsVal(int row, int col, String ans){
    _cSL[row][col].setAnsVal(ans);
    notifyListeners();
  }
  void setUserVal(int row, int col, String usrAns){
    _cSL[row][col].setUserVal(usrAns);
    notifyListeners();
  }
  void setBackgroundColor(int row, int col, Color color){
    _cSL[row][col].setBackgroundColor(color);
    notifyListeners();
  }
  void setTextColor(int row, int col, Color color){
    _cSL[row][col].setTextColor(color);
    notifyListeners();
  }
  void setKeyColor(int index, Color c){
      _keyBoardColor[index] = c;
      notifyListeners();
  }
  void setRow(int value) {
    _row = value;
    notifyListeners();
  }
  void setCol(int value) {
    _col = value;
    notifyListeners();
  }
  void setStop(){
    this._stop = !this._stop;
    notifyListeners();
  }

  Color getKeyBoardColor(int index){
    return _keyBoardColor[index];
  }
  Color getBackgroundColor(int row, int col){
    return _cSL[row][col].getBackgroundColor();
  }
  Color getTextColor(int row, int col){
    return _cSL[row][col].getTextColor();
  }
  String getKeyBoard(int position){
    return this._keyBoard[position].toString();
  }
  String getUserVal(int row, int col){
    if(stop == false)
      return _cSL[row][col].getUserVal();
    return "0";
  }
  String getAnsVal(int row, int col){

    return _cSL[row][col].getAnsVal();
  }

  int get row => _row;
  int get col => _col;
  int get error => _error;
  int get correct => _correct;
  bool get stop => _stop;
}
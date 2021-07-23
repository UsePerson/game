import 'dart:async';
import 'dart:math';
import 'package:sudoku99/sudoku99.dart';

//    so easy : Given 50 up
//       easy : Given 36 ~ 49
//     medium : Given 32 ~ 35
//  difficult : Given 28 ~ 31
//       evil : Given 22 ~ 27


class SudokuGenerator {

  int _boardSize = 9;
  int _boxSize = 3;

  var rand = new Random();
  Solver99 solver = Solver99();
  List<List<int>> _board = List.generate(9, (index) => List.generate(9, (index)=> 0));

  void fillDiagonal(){

    for(int i = 0 ; i < _boardSize ; i += _boxSize)
      fillBox(i, i);
    
  }
  void fillBox(int row, int col){

    int num;
    for (int i = 0 ; i < _boxSize ; i ++ ){

      for(int j = 0 ; j < _boxSize ; j ++ ){

        do{

          num = randomGenerator(_boardSize);

        }while(!inBoxValid(row, col, num));
        _board[row + i][col + j] = num;
      }
    }
  }
  int randomGenerator(int maxNum) {

    // random 1~9
    return rand.nextInt(maxNum)+1;
  }
  bool inBoxValid(int row, int col, int num){

    for(int i = 0 ; i < _boxSize ; i ++ ){

      for(int j = 0 ; j < _boxSize ; j ++ ){

        if(_board[i + row][j + col] == num)
          return false;
      }
    }
    return true;
  }
  bool inRowValid(int row, int num){
    
    for(int i = 0 ; i < _boardSize ; i ++ ){
      
      if(_board[row][i] == num)
        return false;
    }
    return true;
  }
  bool inColValid(int col, int num){

    for(int i = 0 ; i < _boardSize ; i ++ ){

      if(_board[i][col] == num)
        return false;
    }
    return true;
  }

  bool fillRemaining(int i, int j) {

    if(i < (_boardSize-1) && j >= _boardSize){
      i+=1; // let i < 7, become to i+1
      j = 0; // let j = 8, become to 0
    }
    if(i >= _boardSize && j >= _boardSize){
      return true;
    }

    if(i < _boxSize){

      if(j < _boxSize){
        // i = 0~2
        // j = 0~2
        j = _boxSize;
        // j = 3
      }
    }
    else if( i < (_boardSize - _boxSize)){

      if (j== (i~/_boxSize) *_boxSize) {
        // i = 3~5
        // j = 3~5
        j = j + _boxSize;
        // j = 6
      }
    }
    else{

      if (j == _boardSize - _boxSize) {

        i +=1;
        j = 0;
        if ( i>=_boardSize )
          return true;
      }
    }
    for (int num = 1; num <= _boardSize ; num++) {

      if (isValid(i, j, num)) {

        _board[i][j] = num;
        if (fillRemaining(i, j+1))
          return true;

        _board[i][j] = 0;
      }
    }
    return false;
  }
  bool isValid(int r, int c, int num){
    return(
        inRowValid(r, num) &&
        inColValid(c, num) &&
        inBoxValid(r-r%_boxSize, c-c%_boxSize, num)
    );
  }
  bool removeKDigits(int _removeNum) {

    int count = _removeNum;
    int cnt = 0;
    while (count != 0) {
      cnt ++;
      int cellId = randomGenerator(_boardSize*_boardSize)-1;

      int i = (cellId~/_boardSize);
      int j = cellId%9;


      if (_board[i][j] != 0) {

        int tmp = _board[i][j];
        _board[i][j] = 0;
        if(solver.run(Util.toOneBase(_board)) == 1){
          count--;
        }
        else{
          _board[i][j] = tmp;
        }
      }
      if(cnt >= 300)
        return false;
    }

    print('loop : $cnt');
    return true;
  }

  int getBoard(int r, int c){
    return _board[r][c];
  }


}
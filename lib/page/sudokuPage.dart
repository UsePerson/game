import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game/utility/counterTimer.dart';
import 'package:game/utility/sudokuBoard.dart';
import 'package:game/utility/sudokuCellState.dart';
import 'package:scoped_model/scoped_model.dart';

class SudokuPage extends StatelessWidget {

  CellStateList board = CellStateList();
  final String title;
  SudokuPage(this.title);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: GestureDetector(
        // onTap: ()
        child: Column(
          children: [
            TimerBlock(),
            ScopedModel<CellStateList>(
              model: board,
              child: SudokuBoard(),
            )
            // keyboard
          ],
        ),
      ),
    );
  }
}
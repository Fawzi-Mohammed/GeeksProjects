import 'dart:io';
import 'Terminal.dart';

class TicTacToe {
  late List<String> board;
  late String currentPlayer;
  late bool vsComputer;
  late String humanMarker;
  late String computerMarker;
  TicTacToe() {
    board = List.generate(9, (index) => (index + 1).toString());
    currentPlayer = 'X';
    print('\n${TerminalColors.yellow}Game setup:${TerminalColors.reset}');
    print('1. Play against a friend');
    print('2. Play against computer');
    print(
      '${TerminalColors.cyan}Enter choice (1 or 2):${TerminalColors.reset}',
    );
    final choice = _getNumberInput(1, 2);
    vsComputer = choice == 2;
    if (vsComputer) {
      print(
        '${TerminalColors.cyan}Choose your marker (X or O):${TerminalColors.reset}',
      );
      print('X goes first, O goes second');
      humanMarker = stdin.readLineSync()!.toUpperCase();
      computerMarker = humanMarker == 'X' ? 'O' : 'X';
      while (humanMarker != 'X' && humanMarker != 'O') {
        print(
          '${TerminalColors.red}Invalid choice. Please enter X or O:'
          '${TerminalColors.reset}',
        );
        humanMarker = stdin.readLineSync()!.toUpperCase();
      }
      computerMarker = humanMarker == 'X' ? 'O' : 'X';
      print(
        '\n${TerminalColors.green}You are ${humanMarker}, '
        'computer is ${computerMarker}${TerminalColors.reset}',
      );
    } else {
      print(
        '\n${TerminalColors.green}Player 1 is X, Player 2 is O'
        '${TerminalColors.reset}',
      );
    }
  }

  void play() {
    print('\n${TerminalColors.green}Game started!${TerminalColors.reset}');
    printBoard();
    while (true) {
      if (vsComputer && currentPlayer == computerMarker) {
        _computerMove();
      } else {
        _humanMove();
      }
      printBoard();
       
      if (_checkwin(currentPlayer)) {
        _showWinMessage();
        return;
      } 
      if (_checkDraw()) {
        print('\n${TerminalColors.yellow}${TerminalColors.bold}'
            'It\'s a draw! 🤝'
            '${TerminalColors.reset}');
        return;
      }
      currentPlayer = currentPlayer == 'X' ? 'O' : 'X';


    }
  }

  int _getNumberInput(int min, int max, {bool validatePosition = false}) {
    while (true) {
      try {
        final input = stdin.readLineSync()!;
        if (input.isEmpty)
          throw FormatException('Input cannot be empty');
        final number = int.parse(input);
        if (number < min || number > max) {
          print(
            '${TerminalColors.red}Please enter a number between $min and $max.'
            '${TerminalColors.reset}',
          );
          continue;
        }

        ///
        if (validatePosition && board[number - 1] != number.toString()) {
          print(
            '${TerminalColors.red}That position is already taken. '
            'Choose another.${TerminalColors.reset}',
          );
          continue;
        }
        return number;
      } on FormatException {
        print(
          '${TerminalColors.red}Invalid input. Please enter a number.'
          '${TerminalColors.reset}',
        );
      }
    }
  }

  void printBoard() {
    for (int i = 0; i < 9; i += 3) {
      final row = board
          .sublist(i, i + 3)
          .map((cell) {
            if (cell == 'X')
              return '${TerminalColors.green}X${TerminalColors.reset}';
            if (cell == 'O')
              return '${TerminalColors.red}O${TerminalColors.reset}';
            return cell;
          })
          .join('|');
      print(' $row ');
      if (i < 6) print('-----------');
    }
  }

  bool _checkDraw() {
    for (var i = 0; i < 9; i++) {
      if (board[i] == (i + 1).toString()) {
        return false;
      }
    }
    return true;
  }

  bool _checkWinOnBoard(String player, List<String> boardToCheck) {
    //check rows
    for (int i = 0; i < 9; i += 3) {
      if (boardToCheck[i] == player &&
          boardToCheck[i + 1] == player &&
          boardToCheck[i + 2] == player) {
        return true;
      }
    }
    //check columns
    for (var i = 0; i < 3; i++) {
      if (boardToCheck[i] == player &&
          boardToCheck[i + 3] == player &&
          boardToCheck[i + 6] == player) {
        return true;
      }
    }
    //check diagonals
    if (boardToCheck[0] == player &&
        boardToCheck[4] == player &&
        boardToCheck[8] == player) {
      return true;
    }
    if (boardToCheck[2] == player &&
        boardToCheck[4] == player &&
        boardToCheck[6] == player) {
      return true;
    }
    return false;
  }

  bool _checkwin(String player) => _checkWinOnBoard(player, board);

  void _showWinMessage() {
    final winner = currentPlayer;
    final message =
        vsComputer && winner == computerMarker
            ? '${TerminalColors.red}Computer wins! 😈${TerminalColors.reset}'
            : '${TerminalColors.green}${TerminalColors.bold}'
                'Player $winner wins! 🎉${TerminalColors.reset}';
    print('\n$message');
  }

  void _humanMove() {
    print(
      '\n${TerminalColors.cyan}Player ${currentPlayer}\'s turn. '
      'Enter position (1-9):${TerminalColors.reset}',
    );
    final move = _getNumberInput(1, 9, validatePosition: true);
    board[move - 1] = currentPlayer;
  }

  int _getComputerMove() {
    //Try to win
    for (var i = 0; i < 9; i++) {
      if (board[i] == (i + 1).toString()) {
        final tempBoard = List<String>.from(board);
        tempBoard[i] = computerMarker;

        if (_checkWinOnBoard(computerMarker, tempBoard)) {
          return i + 1;
        }
      }
    }
    //Block player
    for (var i = 0; i < 9; i++) {
      if (board[i] == (i + 1).toString()) {
        final tempBoard = List<String>.from(board);
        tempBoard[i] = humanMarker;

        if (_checkWinOnBoard(humanMarker, tempBoard)) {
          return i + 1;
        }
      }
    }
    // Take center
    if (board[4] == '5') return 5;
    // Take a corner
    // Take a corner
    final corners = [0, 2, 6, 8];
    final availableCorners = corners.where(
      (i) => board[i] == (i + 1).toString(),
    );
    if (availableCorners.isNotEmpty) {
      return availableCorners.first + 1;
    }

    // Random move
    final availableMoves = <int>[];
    for (var i = 0; i < 9; i++) {
      if (board[i] == (i + 1).toString()) {
        availableMoves.add(i + 1);
      }
    }
    return availableMoves.first;
  }

  void _computerMove() {
    print(
      '\n${TerminalColors.magenta}Computer\'s turn ($computerMarker)...'
      '${TerminalColors.reset}',
    );
    sleep(const Duration(seconds: 1)); // Pause for realism
    final move = _getComputerMove();
    board[move - 1] = computerMarker;
    print('Computer chooses position $move');
  }
}

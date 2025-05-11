import 'dart:io';
import 'models/Tic-Tack.dart';
import 'models/Terminal.dart';

void main() {
   
   print('${TerminalColors.green}${TerminalColors.bold}'
      '🎮 Welcome to Tic-Tac-Toe! 🎮'
      '${TerminalColors.reset}');
  print('\nUse numbers 1-9 to play, like a phone keypad:');
  print(' 1 | 2 | 3 ');
  print('-----------');
  print(' 4 | 5 | 6 ');
  print('-----------');
  print(' 7 | 8 | 9 ');
  while (true) {
    final game = TicTacToe();
    game.play();

    print('\n${TerminalColors.cyan}Play again? (y/n)${TerminalColors.reset}');
    final playAgain = stdin.readLineSync()?.toLowerCase();
    if (playAgain != 'y') {
      print('\n${TerminalColors.green}Thanks for playing! Goodbye. 👋'
          '${TerminalColors.reset}');
      break;
    }
    print('\n${TerminalColors.blue}New game starting...${TerminalColors.reset}');
  }
   

}

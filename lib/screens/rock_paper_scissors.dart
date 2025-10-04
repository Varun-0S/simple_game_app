import 'package:flutter/material.dart';
import 'dart:math';
import '../widgets/score_display.dart';
import '../utils/constants.dart';

class RockPaperScissors extends StatefulWidget {
  const RockPaperScissors({super.key});

  @override
  RockPaperScissorsState createState() => RockPaperScissorsState();
}

class RockPaperScissorsState extends State<RockPaperScissors> {
  String playerChoice = '';
  String computerChoice = '';
  String result = '';
  int playerScore = 0;
  int computerScore = 0;

  final List<String> choices = ['Rock', 'Paper', 'Scissors'];

  void play(String choice) {
    String compChoice = choices[Random().nextInt(3)];
    String res;

    if (choice == compChoice) {
      res = "It's a Tie!";
    } else if ((choice == 'Rock' && compChoice == 'Scissors') ||
        (choice == 'Paper' && compChoice == 'Rock') ||
        (choice == 'Scissors' && compChoice == 'Paper')) {
      res = "You Win!";
      playerScore += 1;
    } else {
      res = "Computer Wins!";
      computerScore += 1;
    }

    setState(() {
      playerChoice = choice;
      computerChoice = compChoice;
      result = res;
    });
  }

  void resetGame() {
    setState(() {
      playerChoice = '';
      computerChoice = '';
      result = '';
      playerScore = 0;
      computerScore = 0;
    });
  }

  Widget buildChoiceButton(String choice) {
    return InkWell(
      onTap: () => play(choice),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 100,
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.secondary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4,
              offset: Offset(2, 4),
            ),
          ],
        ),
        child: Text(
          choice,
          style: const TextStyle(
              color: AppColors.text, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double spacing = MediaQuery.of(context).size.width * 0.05;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rock-Paper-Scissors',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.refresh, color: Colors.white), onPressed: resetGame),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(spacing),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Choose your move:',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: spacing),
            Wrap(
              spacing: spacing,
              children: choices.map((c) => buildChoiceButton(c)).toList(),
            ),
            SizedBox(height: spacing * 2),
            if (playerChoice.isNotEmpty)
              Column(
                children: [
                  ScoreDisplay(label: 'Your Score', score: playerScore),
                  ScoreDisplay(label: 'Computer Score', score: computerScore),
                  const SizedBox(height: 20),
                  Text('Your Choice: $playerChoice',
                      style: const TextStyle(fontSize: 18)),
                  Text('Computer Choice: $computerChoice',
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 20),
                  Text(
                    result,
                    style: const TextStyle(
                        fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

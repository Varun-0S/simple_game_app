import 'dart:math';
import 'package:flutter/material.dart';
import '../widgets/score_display.dart';
import '../utils/constants.dart';

class MathQuiz extends StatefulWidget {
  const MathQuiz({super.key});

  @override
  MathQuizState createState() => MathQuizState();
}

class MathQuizState extends State<MathQuiz> {
  final Random random = Random();
  late int num1;
  late int num2;
  late String operator;
  late int correctAnswer;
  late List<int> options;
  int score = 0;

  @override
  void initState() {
    super.initState();
    generateQuestion();
  }

  void generateQuestion() {
    num1 = random.nextInt(20) + 1;
    num2 = random.nextInt(20) + 1;
    List<String> ops = ['+', '-', '×'];
    operator = ops[random.nextInt(3)];

    switch (operator) {
      case '+':
        correctAnswer = num1 + num2;
        break;
      case '-':
        correctAnswer = num1 - num2;
        break;
      case '×':
        correctAnswer = num1 * num2;
        break;
    }

    // Generate 3 wrong answers
    options = [correctAnswer];
    while (options.length < 4) {
      int option = correctAnswer + random.nextInt(10) - 5;
      if (!options.contains(option)) options.add(option);
    }

    options.shuffle();
  }

  void answer(int choice) {
    if (choice == correctAnswer) {
      score += 1;
    }
    setState(() {
      generateQuestion();
    });
  }

  void resetGame() {
    setState(() {
      score = 0;
      generateQuestion();
    });
  }

  Widget buildOptionButton(int option) {
    return InkWell(
      onTap: () => answer(option),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.primary, AppColors.secondary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(2, 4)),
          ],
        ),
        child: Text(
          option.toString(),
          style: const TextStyle(
              color: AppColors.text, fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double spacing = MediaQuery.of(context).size.width * 0.05;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Math Quiz', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(icon: const Icon(Icons.refresh, color: Colors.white), onPressed: resetGame),
        ],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(spacing),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ScoreDisplay(label: 'Score', score: score),
              SizedBox(height: spacing * 2),
              Text(
                '$num1 $operator $num2 = ?',
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: spacing * 2),
              SizedBox(
                width: double.infinity,
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: spacing,
                  crossAxisSpacing: spacing,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: options.map((option) => buildOptionButton(option)).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

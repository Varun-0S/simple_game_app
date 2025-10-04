import 'package:flutter/material.dart';

class ScoreDisplay extends StatelessWidget {
  final String label;
  final int score;

  const ScoreDisplay({required this.label, required this.score, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      '$label: $score',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }
}

import 'package:flutter/material.dart';
import 'dart:math';
import '../widgets/card_tile.dart';
import '../widgets/score_display.dart';
import '../utils/constants.dart';

class MemoryGame extends StatefulWidget {
  const MemoryGame({super.key});

  @override
  MemoryGameState createState() => MemoryGameState();
}

class MemoryGameState extends State<MemoryGame> {
  late List<IconData> cards;
  late List<bool> flipped;
  List<int> flippedIndex = [];
  int matches = 0;

  @override
  void initState() {
    super.initState();
    initializeCards();
  }

  void initializeCards() {
    cards = [...AppIcons.iconList, ...AppIcons.iconList]; // duplicate icons
    cards.shuffle(Random());
    flipped = List<bool>.filled(cards.length, false);
    flippedIndex.clear();
    matches = 0;
  }

  void flipCard(int index) {
    if (flipped[index] || flippedIndex.length == 2) return;

    setState(() {
      flipped[index] = true;
      flippedIndex.add(index);
    });

    if (flippedIndex.length == 2) {
      Future.delayed(const Duration(seconds: 1), () {
        setState(() {
          int first = flippedIndex[0];
          int second = flippedIndex[1];
          if (cards[first] != cards[second]) {
            flipped[first] = false;
            flipped[second] = false;
          } else {
            matches += 1;
          }
          flippedIndex.clear();
        });
      });
    }
  }

  void resetGame() {
    setState(() {
      initializeCards();
    });
  }

  @override
  Widget build(BuildContext context) {
    double spacing = MediaQuery.of(context).size.width * 0.02;
    int crossAxisCount = MediaQuery.of(context).size.width > 600 ? 6 : 4;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Memory Game',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(icon: const Icon(Icons.refresh, color: Colors.white), onPressed: resetGame)
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          ScoreDisplay(label: 'Matches', score: matches),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(spacing),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: spacing,
                crossAxisSpacing: spacing,
              ),
              itemCount: cards.length,
              itemBuilder: (context, index) {
                return CardTile(
                  flipped: flipped[index],
                  icon: cards[index],
                  onTap: () => flipCard(index),
                  gradientColors: [
                    AppColors.primary.withOpacity(0.8),
                    AppColors.secondary.withOpacity(0.8)
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

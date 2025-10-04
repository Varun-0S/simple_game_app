import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import '../utils/constants.dart';
import 'memory_game.dart';
import 'rock_paper_scissors.dart';
import 'math_quiz.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double spacing = MediaQuery.of(context).size.width * 0.05;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Fun Game Hub',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(spacing),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Choose a Game',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: spacing * 2),
            Expanded(
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 20,
                  crossAxisSpacing: 20,
                  childAspectRatio: 1.2,
                ),
                children: [
                  buildGameCard(
                    context,
                    title: 'Memory Game',
                    icon: Icons.view_module,
                    colors: [AppColors.primary, AppColors.secondary],
                    page: const MemoryGame(),
                  ),
                  buildGameCard(
                    context,
                    title: 'Rock-Paper-Scissors',
                    icon: Icons.content_cut,
                    colors: [AppColors.secondary, AppColors.button],
                    page: const RockPaperScissors(),
                  ),
                  buildGameCard(
                    context,
                    title: 'Math Quiz',
                    icon: Icons.calculate,
                    colors: [AppColors.button, AppColors.fallingObject],
                    page: const MathQuiz(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGameCard(BuildContext context,
      {required String title,
        required IconData icon,
        required List<Color> colors,
        required Widget page}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => page));
      },
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: colors),
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 8,
              offset: Offset(2, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: AppColors.text),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.text,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

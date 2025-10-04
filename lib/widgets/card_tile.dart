import 'package:flutter/material.dart';

class CardTile extends StatelessWidget {
  final bool flipped;
  final IconData icon;
  final VoidCallback onTap;
  final List<Color>? gradientColors;

  const CardTile({
    required this.flipped,
    required this.icon,
    required this.onTap,
    this.gradientColors,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          gradient: flipped
              ? null
              : LinearGradient(
            colors: gradientColors ??
                [Colors.grey.shade400, Colors.grey.shade300],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          color: flipped ? Colors.white : null,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6,
              offset: Offset(2, 4),
            ),
          ],
        ),
        child: Center(
          child: flipped
              ? Icon(icon, size: 36, color: Colors.deepPurple)
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}

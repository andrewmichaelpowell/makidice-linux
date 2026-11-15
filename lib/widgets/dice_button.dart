// Maki Dice (Linux)
// github.com/andrewmichaelpowell

import 'package:flutter/material.dart';

class DiceButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Color tint;
  final Color contentColor;
  final VoidCallback onPressed;

  const DiceButton({
    super.key,
    required this.label,
    this.icon,
    required this.tint,
    this.contentColor = Colors.white,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: tint,
          foregroundColor: contentColor,
          disabledBackgroundColor: tint.withOpacity(0.5),
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 6),
          shape: const StadiumBorder(),
        ).copyWith(
          overlayColor: WidgetStateProperty.resolveWith<Color?>((states) {
            if (states.contains(WidgetState.pressed)) {
              return Colors.black.withOpacity(0.18);
            }
            return Colors.transparent;
          }),
        ),
        child: icon != null
            ? Icon(icon, size: 24, semanticLabel: label)
            : FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  label,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
      ),
    );
  }
}

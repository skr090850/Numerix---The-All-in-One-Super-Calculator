import 'package:flutter/material.dart';

class CalculatorButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const CalculatorButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final bgColor = backgroundColor ?? _getButtonColor(text, context);
    final fgColor = foregroundColor ?? Colors.white;

    return MaterialButton(
      onPressed: onPressed,
      shape: const CircleBorder(),
      color: bgColor,
      textColor: fgColor,
      padding: const EdgeInsets.all(16),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 28,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // Button ke text ke aadhar par color decide karne wala helper function.
  Color _getButtonColor(String text, BuildContext context) {
    final theme = Theme.of(context);
    if (['÷', 'x', '-', '+', '='].contains(text)) {
      return theme.colorScheme.secondary; // Accent color for operators
    }
    if (['AC', '()', '%'].contains(text)) {
      return theme.brightness == Brightness.dark
          ? Colors.grey[800]!
          : Colors.grey[500]!; // Lighter/darker grey for special functions
    }
    return theme.cardColor; // Default color
  }
}

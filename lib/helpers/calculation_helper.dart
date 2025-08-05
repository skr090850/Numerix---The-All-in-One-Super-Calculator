import 'package:math_expressions/math_expressions.dart';

// Yeh class standard aur scientific calculations ke mukhya logic ko handle karti hai.
class CalculationHelper {
  // Is class ka object na ban paye, isliye private constructor.
  CalculationHelper._();

  // Di gayi string expression ko evaluate (solve) karta hai.
  static String evaluateExpression(String expression) {
    if (expression.isEmpty) return '';

    try {
      // '×' aur '÷' ko '*' aur '/' se replace karna zaroori hai math_expressions ke liye.
      String finalExpression = expression.replaceAll('×', '*').replaceAll('÷', '/');

      // Expression ko parse karte hain.
      Parser p = Parser();
      Expression exp = p.parse(finalExpression);

      // Context model ke saath expression ko evaluate karte hain.
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      // Agar result ek integer hai (e.g., 12.0), to use bina decimal ke dikhayein (e.g., 12).
      if (eval == eval.toInt()) {
        return eval.toInt().toString();
      }

      // Varna use double ke roop mein dikhayein.
      return eval.toString();
    } catch (e) {
      // Agar koi error aata hai (e.g., "12++5" ya "12/0")
      return 'Error';
    }
  }
}

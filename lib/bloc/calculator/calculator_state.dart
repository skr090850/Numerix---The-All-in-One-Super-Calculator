import 'package:equatable/equatable.dart';

// Yeh file calculator UI ki current state ko define karti hai.
class CalculatorState extends Equatable {
  // Jo expression ban raha hai (e.g., "12+5")
  final String expression;
  // Jo result dikh raha hai (e.g., "17")
  final String result;

  const CalculatorState({
    this.expression = '',
    this.result = '',
  });

  // Nayi state banane ke liye ek helper method.
  CalculatorState copyWith({
    String? expression,
    String? result,
  }) {
    return CalculatorState(
      expression: expression ?? this.expression,
      result: result ?? this.result,
    );
  }

  @override
  List<Object> get props => [expression, result];
}

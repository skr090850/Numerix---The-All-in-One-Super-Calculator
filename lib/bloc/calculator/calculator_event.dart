import 'package:equatable/equatable.dart';

// Yeh file calculator se jude sabhi possible user actions (events) ko define karti hai.
abstract class CalculatorEvent extends Equatable {
  const CalculatorEvent();

  @override
  List<Object> get props => [];
}

// Jab user koi number (0-9) ya decimal point (.) dabata hai.
class NumberPressed extends CalculatorEvent {
  final String number;
  const NumberPressed(this.number);

  @override
  List<Object> get props => [number];
}

// Jab user koi operator (+, -, ×, ÷) dabata hai.
class OperatorPressed extends CalculatorEvent {
  final String operator;
  const OperatorPressed(this.operator);

  @override
  List<Object> get props => [operator];
}

// Jab user equals (=) ka button dabata hai.
class EqualsPressed extends CalculatorEvent {}

// Jab user backspace (⌫) ka button dabata hai.
class DeletePressed extends CalculatorEvent {}

// Jab user All Clear (AC) ka button dabata hai.
class AllClearPressed extends CalculatorEvent {}

// Jab user percentage (%) ka button dabata hai. (NAYA EVENT)
class PercentagePressed extends CalculatorEvent {}

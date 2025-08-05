import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_expressions/math_expressions.dart';
import 'calculator_event.dart';
import 'calculator_state.dart';

// Yeh BLoC calculator ke poore logic ko handle karega.
class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  CalculatorBloc() : super(const CalculatorState()) {
    // Har event ke liye handler register kar rahe hain.
    on<NumberPressed>(_onNumberPressed);
    on<OperatorPressed>(_onOperatorPressed);
    on<AllClearPressed>(_onAllClearPressed);
    on<DeletePressed>(_onDeletePressed);
    on<EqualsPressed>(_onEqualsPressed);
    on<PercentagePressed>(_onPercentagePressed); // Naya handler
  }

  void _onNumberPressed(NumberPressed event, Emitter<CalculatorState> emit) {
    emit(state.copyWith(expression: state.expression + event.number));
  }

  void _onOperatorPressed(OperatorPressed event, Emitter<CalculatorState> emit) {
    if (state.expression.isNotEmpty &&
        !['+', '-', '×', '÷'].contains(state.expression.substring(state.expression.length - 1))) {
      emit(state.copyWith(expression: state.expression + event.operator));
    }
  }

  void _onAllClearPressed(AllClearPressed event, Emitter<CalculatorState> emit) {
    emit(const CalculatorState());
  }

  void _onDeletePressed(DeletePressed event, Emitter<CalculatorState> emit) {
    if (state.expression.isNotEmpty) {
      emit(state.copyWith(
        expression: state.expression.substring(0, state.expression.length - 1),
      ));
    }
  }
  
  // Percentage button ke liye naya logic.
  void _onPercentagePressed(PercentagePressed event, Emitter<CalculatorState> emit) {
    if (state.expression.isNotEmpty) {
      // Expression ko solve karke result ko 100 se divide karte hain.
      try {
        String finalExpression = state.expression.replaceAll('×', '*').replaceAll('÷', '/');
        Parser p = Parser();
        Expression exp = p.parse(finalExpression);
        ContextModel cm = ContextModel();
        double eval = exp.evaluate(EvaluationType.REAL, cm);
        
        emit(state.copyWith(expression: (eval / 100).toString(), result: ''));
      } catch (e) {
        // Error state ko handle karna
      }
    }
  }

  void _onEqualsPressed(EqualsPressed event, Emitter<CalculatorState> emit) {
    try {
      String finalExpression = state.expression.replaceAll('×', '*').replaceAll('÷', '/');
      Parser p = Parser();
      Expression exp = p.parse(finalExpression);
      ContextModel cm = ContextModel();
      double eval = exp.evaluate(EvaluationType.REAL, cm);

      // Agar result integer hai to .0 hatayein
      final resultString = eval.truncateToDouble() == eval ? eval.toInt().toString() : eval.toString();
      emit(state.copyWith(result: resultString));
    } catch (e) {
      emit(state.copyWith(result: 'Error'));
    }
  }
}

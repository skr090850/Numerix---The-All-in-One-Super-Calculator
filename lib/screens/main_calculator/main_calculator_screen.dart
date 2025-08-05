import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numerix/bloc/calculator/calculator_bloc.dart';
import 'package:numerix/bloc/calculator/calculator_event.dart';
import 'package:numerix/bloc/calculator/calculator_state.dart';
import 'package:numerix/widgets/calculator_button.dart';
import 'package:numerix/widgets/calculator_display.dart';
import 'package:numerix/widgets/custom_app_bar.dart';

class MainCalculatorScreen extends StatelessWidget {
  const MainCalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> buttons = [
      'AC', '()', '%', '÷',
      '7', '8', '9', 'x',
      '4', '5', '6', '-',
      '1', '2', '3', '+',
      '0', '.', '⌫', '=',
    ];

    return BlocProvider(
      create: (context) => CalculatorBloc(),
      child: Scaffold(
        appBar: const CustomAppBar(title: 'Standard Calculator'),
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: BlocBuilder<CalculatorBloc, CalculatorState>(
                builder: (context, state) {
                  return CalculatorDisplay(
                    expression: state.expression,
                    result: state.result,
                  );
                },
              ),
            ),
            const Divider(height: 1),
            Expanded(
              flex: 3,
              child: GridView.builder(
                padding: const EdgeInsets.all(12.0),
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemCount: buttons.length,
                itemBuilder: (context, index) {
                  final buttonText = buttons[index];
                  
                  return CalculatorButton(
                    text: buttonText,
                    onPressed: () {
                      _onButtonPressed(context, buttonText);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onButtonPressed(BuildContext context, String buttonText) {
    final bloc = context.read<CalculatorBloc>();

    if (double.tryParse(buttonText) != null || buttonText == '.') {
      bloc.add(NumberPressed(buttonText));
    } else if (['+', '-', '×', '÷'].contains(buttonText)) {
      bloc.add(OperatorPressed(buttonText));
    } else if (buttonText == '=') {
      bloc.add(EqualsPressed());
    } else if (buttonText == 'AC') {
      bloc.add(AllClearPressed());
    } else if (buttonText == '⌫') {
      bloc.add(DeletePressed());
    } else if (buttonText == '%') {
      bloc.add(PercentagePressed());
    }
    // TODO: Handle '()' button
  }
}

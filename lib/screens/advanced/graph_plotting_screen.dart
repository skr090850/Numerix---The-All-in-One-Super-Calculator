import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:numerix/widgets/custom_app_bar.dart';

class GraphPlottingScreen extends StatefulWidget {
  const GraphPlottingScreen({super.key});

  @override
  State<GraphPlottingScreen> createState() => _GraphPlottingScreenState();
}

class _GraphPlottingScreenState extends State<GraphPlottingScreen> {
  final TextEditingController _functionController = TextEditingController(text: 'x^2');
  List<FlSpot> _spots = [];

  @override
  void initState() {
    super.initState();
    _plotFunction(); // Initial plot
  }

  void _plotFunction() {
    final List<FlSpot> newSpots = [];
    final String expressionText = _functionController.text;
    if (expressionText.isEmpty) {
      setState(() {
        _spots = [];
      });
      return;
    }

    try {
      Parser p = Parser();
      Expression exp = p.parse(expressionText);
      ContextModel cm = ContextModel();

      // -10 se 10 tak ke x-values ke liye points generate karte hain.
      for (double x = -10; x <= 10; x += 0.5) {
        cm.bindVariable(Variable('x'), Number(x));
        final double y = exp.evaluate(EvaluationType.REAL, cm);
        // Agar y-value valid hai to hi add karein.
        if (!y.isNaN && !y.isInfinite) {
          newSpots.add(FlSpot(x, y));
        }
      }
    } catch (e) {
      print("Error parsing/evaluating expression: $e");
      // Error hone par spots ko clear kar dein.
      setState(() {
        _spots = [];
      });
      return;
    }

    setState(() {
      _spots = newSpots;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Graph Plotting'),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input field for function
            TextField(
              controller: _functionController,
              decoration: InputDecoration(
                labelText: 'Enter a function of x (e.g., sin(x), x^2)',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.play_arrow),
                  onPressed: _plotFunction,
                ),
              ),
            ),
            const SizedBox(height: 24),
            // Chart display area
            Expanded(
              child: _spots.isNotEmpty
                  ? LineChart(
                      LineChartData(
                        gridData: const FlGridData(show: true),
                        titlesData: const FlTitlesData(show: true),
                        borderData: FlBorderData(show: true),
                        lineBarsData: [
                          LineChartBarData(
                            spots: _spots,
                            isCurved: true,
                            color: Theme.of(context).primaryColor,
                            barWidth: 3,
                            isStrokeCapRound: true,
                            dotData: const FlDotData(show: false),
                          ),
                        ],
                      ),
                    )
                  : const Center(
                      child: Text('Enter a valid function to see the graph.'),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

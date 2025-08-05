import 'package:flutter/material.dart';
import 'package:numerix/helpers/matrix_helper.dart';
import 'package:numerix/widgets/custom_app_bar.dart';
import 'package:numerix/widgets/matrix_input_grid.dart';

// Matrix operations ke liye ek enum.
enum MatrixOperation { add, subtract, multiply }

class MatrixCalculatorScreen extends StatefulWidget {
  const MatrixCalculatorScreen({super.key});

  @override
  State<MatrixCalculatorScreen> createState() => _MatrixCalculatorScreenState();
}

class _MatrixCalculatorScreenState extends State<MatrixCalculatorScreen> {
  // Abhi ke liye fixed 2x2 matrices.
  int _rows = 2;
  int _cols = 2;

  List<List<double>> _matrixA = [[0, 0], [0, 0]];
  List<List<double>> _matrixB = [[0, 0], [0, 0]];
  List<List<double>>? _resultMatrix;
  String _errorMessage = '';

  MatrixOperation _selectedOperation = MatrixOperation.add;

  void _calculate() {
    setState(() {
      _errorMessage = '';
      _resultMatrix = null;
      try {
        switch (_selectedOperation) {
          case MatrixOperation.add:
            _resultMatrix = MatrixHelper.add(_matrixA, _matrixB);
            break;
          case MatrixOperation.subtract:
            // Subtract ke liye helper banana hoga, abhi ke liye placeholder
            // _resultMatrix = MatrixHelper.subtract(_matrixA, _matrixB);
            break;
          case MatrixOperation.multiply:
            _resultMatrix = MatrixHelper.multiply(_matrixA, _matrixB);
            break;
        }
      } catch (e) {
        _errorMessage = e.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Matrix Calculator'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Matrix A
            const Text('Matrix A', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            MatrixInputGrid(
              rows: _rows,
              cols: _cols,
              onMatrixChanged: (matrix) {
                _matrixA = matrix;
              },
            ),
            const SizedBox(height: 24),

            // Matrix B
            const Text('Matrix B', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            MatrixInputGrid(
              rows: _rows,
              cols: _cols,
              onMatrixChanged: (matrix) {
                _matrixB = matrix;
              },
            ),
            const SizedBox(height: 24),

            // Operations
            SegmentedButton<MatrixOperation>(
              segments: const [
                ButtonSegment(value: MatrixOperation.add, label: Text('+')),
                ButtonSegment(value: MatrixOperation.subtract, label: Text('-')),
                ButtonSegment(value: MatrixOperation.multiply, label: Text('×')),
              ],
              selected: {_selectedOperation},
              onSelectionChanged: (newSelection) {
                setState(() {
                  _selectedOperation = newSelection.first;
                });
              },
            ),
            const SizedBox(height: 24),

            // Calculate Button
            ElevatedButton(
              onPressed: _calculate,
              child: const Text('Calculate'),
            ),
            const SizedBox(height: 24),

            // Result
            const Text('Result', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            if (_errorMessage.isNotEmpty)
              Text('Error: $_errorMessage', style: const TextStyle(color: Colors.red)),
            if (_resultMatrix != null) _buildResultMatrix(_resultMatrix!),
          ],
        ),
      ),
    );
  }

  // Result matrix ko display karne wala widget.
  Widget _buildResultMatrix(List<List<double>> matrix) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: matrix.map((row) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: row.map((value) {
              return Text(
                value.toStringAsFixed(2), // 2 decimal places tak
                style: const TextStyle(fontSize: 18),
              );
            }).toList(),
          );
        }).toList(),
      ),
    );
  }
}

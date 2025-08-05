import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Matrix calculator mein number input karne ke liye grid widget.
class MatrixInputGrid extends StatefulWidget {
  final int rows;
  final int cols;
  final Function(List<List<double>>) onMatrixChanged;

  const MatrixInputGrid({
    super.key,
    required this.rows,
    required this.cols,
    required this.onMatrixChanged,
  });

  @override
  State<MatrixInputGrid> createState() => _MatrixInputGridState();
}

class _MatrixInputGridState extends State<MatrixInputGrid> {
  late List<List<TextEditingController>> _controllers;

  @override
  void initState() {
    super.initState();
    _initializeControllers();
  }

  void _initializeControllers() {
    _controllers = List.generate(
      widget.rows,
      (i) => List.generate(
        widget.cols,
        (j) => TextEditingController(),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant MatrixInputGrid oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Agar rows ya cols badalte hain, to controllers ko re-initialize karo.
    if (widget.rows != oldWidget.rows || widget.cols != oldWidget.cols) {
      _initializeControllers();
    }
  }

  @override
  void dispose() {
    // Memory leak se bachne ke liye sabhi controllers ko dispose karna zaroori hai.
    for (var row in _controllers) {
      for (var controller in row) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  void _updateMatrix() {
    // Controllers se values ko double ki list mein convert karke callback bhejna.
    final matrix = _controllers.map((row) {
      return row.map((controller) {
        return double.tryParse(controller.text) ?? 0.0;
      }).toList();
    }).toList();
    widget.onMatrixChanged(matrix);
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true, // Grid ko content ke hisab se shrink karta hai.
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: widget.cols,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: widget.rows * widget.cols,
      itemBuilder: (context, index) {
        final row = index ~/ widget.cols;
        final col = index % widget.cols;
        return TextField(
          controller: _controllers[row][col],
          textAlign: TextAlign.center,
          keyboardType: const TextInputType.numberWithOptions(decimal: true, signed: true),
          inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'^-?\d*\.?\d*'))],
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            contentPadding: EdgeInsets.zero,
          ),
          onChanged: (_) => _updateMatrix(),
        );
      },
    );
  }
}

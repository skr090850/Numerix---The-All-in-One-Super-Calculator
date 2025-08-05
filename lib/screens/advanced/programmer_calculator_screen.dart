import 'package:flutter/material.dart';
import 'package:numerix/widgets/custom_app_bar.dart';

// Number bases ke liye ek enum.
enum NumberBase { hex, dec, oct, bin }

class ProgrammerCalculatorScreen extends StatefulWidget {
  const ProgrammerCalculatorScreen({super.key});

  @override
  State<ProgrammerCalculatorScreen> createState() =>
      _ProgrammerCalculatorScreenState();
}

class _ProgrammerCalculatorScreenState extends State<ProgrammerCalculatorScreen> {
  String _inputValue = '0';
  NumberBase _currentBase = NumberBase.dec;

  // Button press handle karne wala function
  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'AC') {
        _inputValue = '0';
        return;
      }
      if (value == '⌫') {
        if (_inputValue.length > 1) {
          _inputValue = _inputValue.substring(0, _inputValue.length - 1);
        } else {
          _inputValue = '0';
        }
        return;
      }

      if (_inputValue == '0') {
        _inputValue = value;
      } else {
        _inputValue += value;
      }
    });
  }

  // Input value ko alag-alag bases mein convert karne wala function
  String _convert(String value, NumberBase from, NumberBase to) {
    try {
      final int intValue = int.parse(value, radix: _getBaseRadix(from));
      return intValue.toRadixString(_getBaseRadix(to)).toUpperCase();
    } catch (e) {
      return 'Error';
    }
  }

  // Enum se radix (base value) get karne wala helper
  int _getBaseRadix(NumberBase base) {
    switch (base) {
      case NumberBase.hex:
        return 16;
      case NumberBase.dec:
        return 10;
      case NumberBase.oct:
        return 8;
      case NumberBase.bin:
        return 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Programmer'),
      body: Column(
        children: [
          _buildDisplay(),
          const Divider(),
          _buildKeypad(),
        ],
      ),
    );
  }

  // Display area banane wala widget
  Widget _buildDisplay() {
    return Expanded(
      flex: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildConversionRow(NumberBase.hex, 'HEX'),
            _buildConversionRow(NumberBase.dec, 'DEC'),
            _buildConversionRow(NumberBase.oct, 'OCT'),
            _buildConversionRow(NumberBase.bin, 'BIN'),
          ],
        ),
      ),
    );
  }

  // Har conversion row banane wala widget
  Widget _buildConversionRow(NumberBase base, String label) {
    final bool isSelected = _currentBase == base;
    return GestureDetector(
      onTap: () => setState(() {
        _inputValue = _convert(_inputValue, _currentBase, base);
        _currentBase = base;
      }),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        color: isSelected ? Theme.of(context).primaryColor.withOpacity(0.2) : Colors.transparent,
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                isSelected ? _inputValue : _convert(_inputValue, _currentBase, base),
                textAlign: TextAlign.right,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Keypad banane wala widget
  Widget _buildKeypad() {
    // Base ke aadhar par keypad ke buttons define hote hain
    final List<String> keypadButtons = [
      'A', 'B', 'C', 'AND',
      'D', 'E', 'F', 'OR',
      '7', '8', '9', 'XOR',
      '4', '5', '6', 'NOT',
      '1', '2', '3', '⌫',
      '0', 'AC',
    ];

    return Expanded(
      flex: 3,
      child: GridView.builder(
        padding: const EdgeInsets.all(8),
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1.5,
        ),
        itemCount: keypadButtons.length,
        itemBuilder: (context, index) {
          final buttonText = keypadButtons[index];
          // Button ko enable/disable karne ka logic
          final bool isEnabled = _isButtonEnabled(buttonText);

          return ElevatedButton(
            onPressed: isEnabled ? () => _onButtonPressed(buttonText) : null,
            child: Text(buttonText, style: const TextStyle(fontSize: 20)),
          );
        },
      ),
    );
  }

  // Button ko enable/disable karne wala logic
  bool _isButtonEnabled(String text) {
    if (['AND', 'OR', 'XOR', 'NOT'].contains(text)) return false; // TODO: Implement bitwise ops
    if (['A', 'B', 'C', 'D', 'E', 'F'].contains(text)) {
      return _currentBase == NumberBase.hex;
    }
    final int? digit = int.tryParse(text);
    if (digit != null) {
      return digit < _getBaseRadix(_currentBase);
    }
    return true; // For AC, ⌫
  }
}

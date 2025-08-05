import 'package:flutter/material.dart';
import 'package:numerix/widgets/custom_app_bar.dart';

// Alag-alag conversion types ke liye ek enum.
enum ConversionType { length, weight, temperature }

class UnitConverterScreen extends StatefulWidget {
  final String title;
  final ConversionType conversionType;

  const UnitConverterScreen({
    super.key,
    required this.title,
    required this.conversionType,
  });

  @override
  State<UnitConverterScreen> createState() => _UnitConverterScreenState();
}

class _UnitConverterScreenState extends State<UnitConverterScreen> {
  // Conversion data
  late Map<String, double> _units;
  late String _fromUnit;
  late String _toUnit;
  String _inputValue = '1';
  String _resultValue = '';

  // Conversion factors (base unit ke sapeksh)
  final Map<ConversionType, Map<String, double>> _conversionData = {
    ConversionType.length: {
      'Meters': 1.0,
      'Kilometers': 1000.0,
      'Centimeters': 0.01,
      'Feet': 0.3048,
      'Inches': 0.0254,
    },
    ConversionType.weight: {
      'Grams': 1.0,
      'Kilograms': 1000.0,
      'Pounds': 453.592,
      'Ounces': 28.3495,
    },
    // Temperature ke liye alag logic lagega
  };

  @override
  void initState() {
    super.initState();
    _initializeUnits();
  }

  void _initializeUnits() {
    if (widget.conversionType == ConversionType.temperature) {
      _units = {'Celsius': 0, 'Fahrenheit': 1, 'Kelvin': 2};
    } else {
      _units = _conversionData[widget.conversionType]!;
    }
    _fromUnit = _units.keys.first;
    _toUnit = _units.keys.elementAt(1);
    _convert();
  }

  void _convert() {
    final double? input = double.tryParse(_inputValue);
    if (input == null) {
      setState(() => _resultValue = 'Invalid Input');
      return;
    }

    double result;

    if (widget.conversionType == ConversionType.temperature) {
      // Temperature conversion logic
      if (_fromUnit == 'Celsius' && _toUnit == 'Fahrenheit') {
        result = (input * 9 / 5) + 32;
      } else if (_fromUnit == 'Fahrenheit' && _toUnit == 'Celsius') {
        result = (input - 32) * 5 / 9;
      } else {
        // TODO: Add other temperature conversions
        result = input; // Placeholder
      }
    } else {
      // Standard conversion logic
      final double fromValue = _units[_fromUnit]!;
      final double toValue = _units[_toUnit]!;
      result = input * fromValue / toValue;
    }

    setState(() {
      _resultValue = result.toStringAsFixed(4);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // From Unit
            _buildConversionRow(_fromUnit, _inputValue, true),
            const SizedBox(height: 24),
            // Swap Button
            IconButton(
              icon: const Icon(Icons.swap_vert, size: 40),
              onPressed: () {
                setState(() {
                  final temp = _fromUnit;
                  _fromUnit = _toUnit;
                  _toUnit = temp;
                  _convert();
                });
              },
            ),
            const SizedBox(height: 24),
            // To Unit
            _buildConversionRow(_toUnit, _resultValue, false),
          ],
        ),
      ),
    );
  }

  Widget _buildConversionRow(String selectedUnit, String value, bool isInput) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButton<String>(
          value: selectedUnit,
          isExpanded: true,
          items: _units.keys.map((String unit) {
            return DropdownMenuItem<String>(
              value: unit,
              child: Text(unit),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              setState(() {
                if (isInput) {
                  _fromUnit = newValue;
                } else {
                  _toUnit = newValue;
                }
                _convert();
              });
            }
          },
        ),
        const SizedBox(height: 8),
        isInput
            ? TextField(
                controller: TextEditingController(text: _inputValue),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(border: OutlineInputBorder()),
                onChanged: (newValue) {
                  setState(() {
                    _inputValue = newValue;
                    _convert();
                  });
                },
              )
            : Text(
                value,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
      ],
    );
  }
}

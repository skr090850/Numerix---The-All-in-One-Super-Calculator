import 'package:flutter/material.dart';
import 'package:numerix/widgets/custom_app_bar.dart';

enum GstType { add, remove }

class GstCalculatorScreen extends StatefulWidget {
  const GstCalculatorScreen({super.key});

  @override
  State<GstCalculatorScreen> createState() => _GstCalculatorScreenState();
}

class _GstCalculatorScreenState extends State<GstCalculatorScreen> {
  final _amountController = TextEditingController();
  final _rateController = TextEditingController(text: '18');
  
  GstType _selectedGstType = GstType.add;
  String _gstAmount = '';
  String _totalAmount = '';

  void _calculateGst() {
    final double? amount = double.tryParse(_amountController.text);
    final double? rate = double.tryParse(_rateController.text);

    if (amount == null || rate == null || amount <= 0 || rate <= 0) {
      setState(() {
        _gstAmount = '';
        _totalAmount = '';
      });
      return;
    }

    double gstValue;
    double finalAmount;

    if (_selectedGstType == GstType.add) {
      gstValue = amount * (rate / 100);
      finalAmount = amount + gstValue;
    } else { // Remove GST
      gstValue = amount - (amount * (100 / (100 + rate)));
      finalAmount = amount - gstValue;
    }

    setState(() {
      _gstAmount = gstValue.toStringAsFixed(2);
      _totalAmount = finalAmount.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'GST Calculator'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(
              controller: _amountController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'Initial Amount',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => _calculateGst(),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _rateController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              decoration: const InputDecoration(
                labelText: 'GST Rate (%)',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => _calculateGst(),
            ),
            const SizedBox(height: 16),
            SegmentedButton<GstType>(
              segments: const [
                ButtonSegment(value: GstType.add, label: Text('Add GST')),
                ButtonSegment(value: GstType.remove, label: Text('Remove GST')),
              ],
              selected: {_selectedGstType},
              onSelectionChanged: (newSelection) {
                setState(() {
                  _selectedGstType = newSelection.first;
                  _calculateGst();
                });
              },
            ),
            const SizedBox(height: 32),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildResultRow('GST Amount:', '₹ $_gstAmount'),
                    _buildResultRow(
                      _selectedGstType == GstType.add ? 'Net Amount:' : 'Original Amount:',
                      '₹ $_totalAmount',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(fontSize: 16)),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:numerix/widgets/custom_app_bar.dart';

class EmiCalculatorScreen extends StatefulWidget {
  const EmiCalculatorScreen({super.key});

  @override
  State<EmiCalculatorScreen> createState() => _EmiCalculatorScreenState();
}

class _EmiCalculatorScreenState extends State<EmiCalculatorScreen> {
  final _principalController = TextEditingController(text: '100000');
  final _rateController = TextEditingController(text: '10.5');
  final _timeController = TextEditingController(text: '5');
  
  String _emiResult = '';
  String _totalInterest = '';
  String _totalPayment = '';

  @override
  void initState() {
    super.initState();
    _calculateEmi();
  }

  void _calculateEmi() {
    final double? p = double.tryParse(_principalController.text);
    final double? r = double.tryParse(_rateController.text);
    final int? t = int.tryParse(_timeController.text);

    if (p == null || r == null || t == null || p <= 0 || r <= 0 || t <= 0) {
      setState(() {
        _emiResult = '';
        _totalInterest = '';
        _totalPayment = '';
      });
      return;
    }

    // Monthly interest rate
    double monthlyRate = r / 12 / 100;
    // Loan tenure in months
    int tenureInMonths = t * 12;

    // EMI formula: P x R x (1+R)^N / [(1+R)^N-1]
    double emi = (p * monthlyRate * pow(1 + monthlyRate, tenureInMonths)) /
        (pow(1 + monthlyRate, tenureInMonths) - 1);
        
    double totalPaymentValue = emi * tenureInMonths;
    double totalInterestValue = totalPaymentValue - p;

    setState(() {
      _emiResult = emi.toStringAsFixed(2);
      _totalInterest = totalInterestValue.toStringAsFixed(2);
      _totalPayment = totalPaymentValue.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'EMI Calculator'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            _buildTextField(_principalController, 'Loan Amount (₹)'),
            const SizedBox(height: 16),
            _buildTextField(_rateController, 'Interest Rate (%)'),
            const SizedBox(height: 16),
            _buildTextField(_timeController, 'Loan Tenure (Years)'),
            const SizedBox(height: 32),
            _buildResultCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      onChanged: (_) => _calculateEmi(),
    );
  }

  Widget _buildResultCard() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Your EMI Details',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Divider(height: 30),
            _buildResultRow('Monthly EMI:', '₹ $_emiResult'),
            _buildResultRow('Total Interest:', '₹ $_totalInterest'),
            _buildResultRow('Total Payment:', '₹ $_totalPayment'),
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

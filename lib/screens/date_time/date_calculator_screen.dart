import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:numerix/widgets/custom_app_bar.dart';

class DateCalculatorScreen extends StatefulWidget {
  const DateCalculatorScreen({super.key});

  @override
  State<DateCalculatorScreen> createState() => _DateCalculatorScreenState();
}

class _DateCalculatorScreenState extends State<DateCalculatorScreen> {
  DateTime _fromDate = DateTime.now();
  DateTime _toDate = DateTime.now().add(const Duration(days: 1));
  String _differenceResult = '';

  @override
  void initState() {
    super.initState();
    _calculateDifference();
  }

  void _calculateDifference() {
    final difference = _toDate.difference(_fromDate).inDays;
    setState(() {
      _differenceResult = '$difference days';
    });
  }

  Future<void> _selectDate(BuildContext context, bool isFromDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isFromDate ? _fromDate : _toDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        if (isFromDate) {
          _fromDate = picked;
        } else {
          _toDate = picked;
        }
        _calculateDifference();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Date formatting ke liye
    final DateFormat formatter = DateFormat('dd MMMM, yyyy');

    return Scaffold(
      appBar: const CustomAppBar(title: 'Date Calculator'),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Calculate Days Between Dates',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),

            // From Date
            const Text('From Date'),
            const SizedBox(height: 8),
            ListTile(
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              title: Text(formatter.format(_fromDate)),
              trailing: const Icon(Icons.calendar_today),
              onTap: () => _selectDate(context, true),
            ),
            const SizedBox(height: 24),

            // To Date
            const Text('To Date'),
            const SizedBox(height: 8),
            ListTile(
              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              title: Text(formatter.format(_toDate)),
              trailing: const Icon(Icons.calendar_today),
              onTap: () => _selectDate(context, false),
            ),
            const SizedBox(height: 32),

            // Result
            Center(
              child: Column(
                children: [
                  const Text(
                    'Difference',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  Text(
                    _differenceResult,
                    style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            // TODO: Add Age Calculator feature here
          ],
        ),
      ),
    );
  }
}

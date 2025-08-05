import 'package:flutter/material.dart';
import 'package:numerix/screens/financial/emi_calculator_screen.dart';
import 'package:numerix/screens/financial/gst_calculator_screen.dart';
import 'package:numerix/widgets/custom_app_bar.dart';

// Yeh screen alag-alag financial calculators ke liye ek menu ka kaam karti hai.
class FinancialHubScreen extends StatelessWidget {
  const FinancialHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Financial calculator categories ki list.
    final List<Map<String, dynamic>> financialCategories = [
      {'name': 'EMI Calculator', 'icon': Icons.payment, 'screen': const EmiCalculatorScreen()},
      {'name': 'GST Calculator', 'icon': Icons.receipt_long, 'screen': const GstCalculatorScreen()},
      // TODO: Add more financial calculators like Simple/Compound Interest, etc.
    ];

    return Scaffold(
      appBar: const CustomAppBar(title: 'Financial Calculators'),
      body: ListView.builder(
        itemCount: financialCategories.length,
        itemBuilder: (context, index) {
          final category = financialCategories[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Icon(category['icon'], color: Theme.of(context).primaryColor),
              title: Text(category['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => category['screen']),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

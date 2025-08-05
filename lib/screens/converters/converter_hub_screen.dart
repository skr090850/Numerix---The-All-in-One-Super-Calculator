import 'package:flutter/material.dart';
import 'package:numerix/screens/converters/unit_converter_screen.dart';
import 'package:numerix/widgets/custom_app_bar.dart';

// Yeh screen alag-alag unit converter categories ke liye ek menu ka kaam karti hai.
class ConverterHubScreen extends StatelessWidget {
  const ConverterHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Converter categories ki list.
    final List<Map<String, dynamic>> converterCategories = [
      {'name': 'Length', 'icon': Icons.straighten, 'type': ConversionType.length},
      {'name': 'Weight', 'icon': Icons.scale, 'type': ConversionType.weight},
      {'name': 'Temperature', 'icon': Icons.thermostat, 'type': ConversionType.temperature},
      // TODO: Add more converter types like Area, Volume, Speed etc.
    ];

    return Scaffold(
      appBar: const CustomAppBar(title: 'Unit Converters'),
      body: ListView.builder(
        itemCount: converterCategories.length,
        itemBuilder: (context, index) {
          final category = converterCategories[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Icon(category['icon'], color: Theme.of(context).primaryColor),
              title: Text(category['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
              trailing: const Icon(Icons.arrow_forward_ios),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UnitConverterScreen(
                      title: category['name'],
                      conversionType: category['type'],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

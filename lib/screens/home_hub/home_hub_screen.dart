import 'package:flutter/material.dart';
import 'package:numerix/screens/advanced/programmer_calculator_screen.dart';
import 'package:numerix/screens/converters/converter_hub_screen.dart';
import 'package:numerix/screens/date_time/date_calculator_screen.dart';
import 'package:numerix/screens/financial/financial_hub_screen.dart';
import 'package:numerix/screens/main_calculator/main_calculator_screen.dart';
import 'package:numerix/screens/settings/settings_screen.dart';
import 'package:numerix/screens/unique/ai_assistant_screen.dart';
import 'package:numerix/screens/user/profile_screen.dart';
import 'package:numerix/widgets/custom_app_bar.dart';
import 'package:numerix/widgets/home_hub_card.dart';

// Yeh app ki mukhya home screen hai.
class HomeHubScreen extends StatelessWidget {
  const HomeHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Calculator categories ki list.
    // Sabhi 'targetScreen' ko unki sahi screen se joda gaya hai.
    final List<Map<String, dynamic>> calculatorCategories = [
      {
        'title': 'Standard Calculator',
        'icon': Icons.calculate,
        'targetScreen': const MainCalculatorScreen(),
      },
      {
        'title': 'Advanced Calculators',
        'icon': Icons.science,
        'targetScreen': const ProgrammerCalculatorScreen(),
      },
      {
        'title': 'Unit Converters',
        'icon': Icons.straighten,
        'targetScreen': const ConverterHubScreen(),
      },
      {
        'title': 'Financial Calculators',
        'icon': Icons.account_balance,
        'targetScreen': const FinancialHubScreen(),
      },
      {
        'title': 'Date & Time Tools',
        'icon': Icons.date_range,
        'targetScreen': const DateCalculatorScreen(),
      },
      {
        'title': 'Unique Tools',
        'icon': Icons.star,
        'targetScreen': const AiAssistantScreen(), // Abhi ke liye AI Assistant se joda gaya hai
      },
    ];

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Numerix',
        actions: [
          // Settings screen par jaane ke liye icon button
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
          // Profile screen par jaane ke liye icon button
           IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            childAspectRatio: 1.1,
          ),
          itemCount: calculatorCategories.length,
          itemBuilder: (context, index) {
            final category = calculatorCategories[index];
            return HomeHubCard(
              title: category['title'],
              icon: category['icon'],
              onTap: () {
                if (category['targetScreen'] != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => category['targetScreen']),
                  );
                }
              },
            );
          },
        ),
      ),
    );
  }
}

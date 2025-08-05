import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numerix/bloc/theme/theme_bloc.dart';
import 'package:numerix/bloc/theme/theme_event.dart';
import 'package:numerix/bloc/theme/theme_state.dart';
import 'package:numerix/widgets/custom_app_bar.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Placeholder values for other settings
  bool _soundEffects = true;
  bool _hapticFeedback = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Settings'),
      body: ListView(
        children: [
          // Dark Mode Setting
          BlocBuilder<ThemeBloc, AppThemeState>(
            builder: (context, state) {
              return SwitchListTile(
                title: const Text('Dark Mode'),
                secondary: const Icon(Icons.dark_mode),
                value: state.themeMode == ThemeMode.dark,
                onChanged: (bool value) {
                  // ThemeBloc ko event bhej rahe hain
                  context.read<ThemeBloc>().add(ThemeModeChanged(isDarkMode: value));
                },
              );
            },
          ),
          const Divider(),

          // Sound Effects Setting
          SwitchListTile(
            title: const Text('Sound Effects'),
            secondary: const Icon(Icons.volume_up),
            value: _soundEffects,
            onChanged: (bool value) {
              setState(() {
                _soundEffects = value;
                // TODO: Add logic to save this setting
              });
            },
          ),
          const Divider(),

          // Haptic Feedback Setting
          SwitchListTile(
            title: const Text('Haptic Feedback'),
            secondary: const Icon(Icons.vibration),
            value: _hapticFeedback,
            onChanged: (bool value) {
              setState(() {
                _hapticFeedback = value;
                // TODO: Add logic to save this setting
              });
            },
          ),
          const Divider(),
          
          // Language Setting
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Language'),
            subtitle: const Text('English'), // Placeholder
            onTap: () {
              // TODO: Show language selection dialog
            },
          ),
        ],
      ),
    );
  }
}

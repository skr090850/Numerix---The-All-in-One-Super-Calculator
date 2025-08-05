import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Nayi files se Event aur State ko import kar rahe hain.
import 'theme_event.dart';
import 'theme_state.dart';

// --- BLoC ---
// Is file mein ab sirf BLoC ki class hai. Event aur State classes yahan se hata di gayi hain.

class ThemeBloc extends Bloc<ThemeEvent, AppThemeState> {
  // Initial state set karte hain (app Light Mode mein shuru hoga).
  ThemeBloc() : super(const AppThemeState(themeMode: ThemeMode.light)) {
    
    // ThemeModeChanged event ke liye ek event handler register karte hain.
    on<ThemeModeChanged>((event, emit) {
      
      final newThemeMode = event.isDarkMode ? ThemeMode.dark : ThemeMode.light;
      
      // Nayi state ko emit karte hain, jisse UI update ho jayega.
      emit(AppThemeState(themeMode: newThemeMode));

      // TODO: User ki preference ko SharedPreferences ya Firestore mein save karna hai.
    });
  }
}

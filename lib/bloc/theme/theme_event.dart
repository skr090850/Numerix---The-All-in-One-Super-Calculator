import 'package:equatable/equatable.dart';

// Yeh file sabhi theme-related events ko define karti hai.

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

// Yeh event tab trigger hota hai jab user theme switch karta hai.
class ThemeModeChanged extends ThemeEvent {
  final bool isDarkMode;
  const ThemeModeChanged({required this.isDarkMode});

  // props mein `isDarkMode` daalne se BLoC do events ko compare kar payega.
  @override
  List<Object> get props => [isDarkMode];
}

import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';

// Yeh file UI ki theme-related state ko define karti hai.

class AppThemeState extends Equatable {
  final ThemeMode themeMode;
  const AppThemeState({required this.themeMode});

  // props mein `themeMode` daalne se BLoC do states ko compare kar payega.
  @override
  List<Object> get props => [themeMode];
}

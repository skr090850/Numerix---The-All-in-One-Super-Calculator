import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// Ab 'hide' keyword ki zaroorat nahi hai kyunki problem theek ho gayi hai.
import 'package:numerix/bloc/theme/theme_bloc.dart'; 
import 'package:numerix/bloc/theme/theme_state.dart';
import 'package:numerix/screens/home_hub/home_hub_screen.dart';
import 'package:numerix/constants/app_colors.dart';

// Yeh app ka entry point hai. App yahin se shuru hota hai.
void main() {
  // Yahan par Firebase ya anya services ko initialize kiya ja sakta hai.
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();

  runApp(const NumerixApp());
}

class NumerixApp extends StatelessWidget {
  const NumerixApp({super.key});

  @override
  Widget build(BuildContext context) {
    // BlocProvider poore app ko ThemeBloc provide karta hai,
    // taaki kahin se bhi theme change ki ja sake.
    return BlocProvider(
      create: (context) => ThemeBloc(),
      child: BlocBuilder<ThemeBloc, AppThemeState>(
        builder: (context, state) {
          return MaterialApp(
            // Debug banner ko hatata hai.
            debugShowCheckedModeBanner: false,
            
            // App ka title.
            title: 'Numerix',
            
            // Light Mode ke liye theme data.
            theme: ThemeData(
              brightness: Brightness.light,
              primaryColor: AppColors.primaryLight,
              scaffoldBackgroundColor: AppColors.backgroundLight,
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppColors.primaryLight,
                brightness: Brightness.light,
              ),
              useMaterial3: true,
            ),
            
            // Dark Mode ke liye theme data.
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primaryColor: AppColors.primaryDark,
              scaffoldBackgroundColor: AppColors.backgroundDark,
               colorScheme: ColorScheme.fromSeed(
                seedColor: AppColors.primaryDark,
                brightness: Brightness.dark,
              ),
              useMaterial3: true,
            ),
            
            // ThemeBloc ki state ke aadhar par theme mode set karta hai.
            themeMode: state.themeMode,
            
            // App ki home screen, jahan se user shuruaat karega.
            home: const HomeHubScreen(),

            // Yahan par GoRouter ya Navigator 2.0 se sabhi routes define honge.
            // routes: { ... },
          );
        },
      ),
    );
  }
}

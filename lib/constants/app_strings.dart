// Yeh class poore app mein istemal hone wale static text ko define karti hai.
// Isse future mein localization (bhasha badalna) aasan ho jata hai.
class AppStrings {
  // Is class ka object na ban paye, isliye private constructor.
  AppStrings._();

  // --- General ---
  static const String appName = "Numerix";
  static const String settings = "Settings";
  static const String profile = "Profile";

  // --- Home Hub ---
  static const String standardCalculator = "Standard Calculator";
  static const String advancedCalculators = "Advanced Calculators";
  static const String unitConverters = "Unit Converters";
  static const String financialCalculators = "Financial Calculators";
  static const String dateTimeTools = "Date & Time Tools";
  static const String uniqueTools = "Unique Tools";

  // --- Settings Screen ---
  static const String darkMode = "Dark Mode";
  static const String language = "Language";
  static const String soundEffects = "Sound Effects";
  static const String hapticFeedback = "Haptic Feedback";
}

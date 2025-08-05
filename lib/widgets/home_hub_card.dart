import 'package:flutter/material.dart';

// Yeh ek reusable card widget hai jo home screen par har category ko dikhayega.
class HomeHubCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const HomeHubCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // InkWell widget card ko tappable banata hai aur ek ripple effect deta hai.
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.0), // Ripple effect ke liye border radius
      child: Card(
        // Card ko thoda utha hua dikhane ke liye elevation
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // Content ko vertically center mein rakhta hai
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Category ka icon
              Icon(
                icon,
                size: 48.0,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(height: 12.0), // Icon aur title ke beech space
              // Category ka title
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

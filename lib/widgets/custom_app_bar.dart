import 'package:flutter/material.dart';

// Yeh ek custom AppBar widget hai jo PreferredSizeWidget ko implement karta hai.
// Isse hum ise Scaffold ke appBar property mein use kar sakte hain.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions; // Actions optional hain

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // AppBar ka title
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      ),
      // Title ko center mein rakhta hai
      centerTitle: true,
      // AppBar ke neeche halki si shadow
      elevation: 2.0,
      // AppBar ke right side mein dikhne wale action buttons
      actions: actions,
    );
  }

  // Yeh getter AppBar ki height batata hai.
  // kToolbarHeight ek standard Flutter constant hai.
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

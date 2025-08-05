import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:numerix/screens/user/login_screen.dart';
import 'package:numerix/services/auth_service.dart';
import 'package:numerix/widgets/custom_app_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService authService = AuthService();

    return Scaffold(
      appBar: const CustomAppBar(title: 'Profile'),
      body: StreamBuilder<User?>(
        stream: authService.userStream,
        builder: (context, snapshot) {
          // Check for connection state
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // Check if user is logged in
          if (snapshot.hasData && snapshot.data != null) {
            final user = snapshot.data!;
            return _buildUserProfile(context, user, authService);
          } else {
            return _buildLoggedOutView(context);
          }
        },
      ),
    );
  }

  // Widget to show when user is logged in
  Widget _buildUserProfile(BuildContext context, User user, AuthService authService) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Center(
            child: Icon(Icons.person_pin_circle, size: 80),
          ),
          const SizedBox(height: 16),
          Text(
            'Welcome!',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            user.email ?? 'No email provided',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            onPressed: () async {
              await authService.signOut();
              // Popping the screen after sign out
              if (Navigator.of(context).canPop()) {
                 Navigator.of(context).pop();
              }
            },
            icon: const Icon(Icons.logout),
            label: const Text('Sign Out'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  // Widget to show when user is logged out
  Widget _buildLoggedOutView(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'You are not logged in.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 16),
          const Text(
            'Log in to sync your history and settings across devices.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            child: const Text('Login / Register'),
          ),
        ],
      ),
    );
  }
}

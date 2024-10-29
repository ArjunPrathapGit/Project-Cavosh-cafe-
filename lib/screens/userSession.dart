import 'package:flutter/material.dart';
// user_session.dart

class UserSession {
  static final UserSession _instance = UserSession._internal();
  String? username; // Nullable type for username
  static bool isLoggedIn = false;
  factory UserSession() {
    return _instance;
  }

  UserSession._internal();

  // Constructor to set the username
  UserSession.withUsername(String username) {
    this.username = username;
  }

  // Method to set the username
  void setUsername(String username) {
    this.username = username;
     isLoggedIn = true; 
  }

  // Method to fetch the username
  String? getUsername() {
    return username;
  }
    void logout(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevents dialog from closing on tap outside
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Simulate logout delay
    await Future.delayed(const Duration(seconds: 2));

    // Reset session state
    username = null;
    isLoggedIn = false;

    // Close the dialog and navigate to login screen
    Navigator.of(context).pop(); // Close the progress dialog
    Navigator.of(context).pushReplacementNamed('/login');
  }
}

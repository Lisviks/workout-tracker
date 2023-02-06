import 'package:flutter/material.dart';
import 'package:wortra/services/auth.dart';
import 'package:wortra/services/firestore.dart';

// ChatGPT code
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            child: const Text('signout'),
            onPressed: () async {
              final NavigatorState navState =
                  context.findAncestorStateOfType<NavigatorState>() ??
                      Navigator.of(context);
              await AuthService().signOut();
              navState.pushNamedAndRemoveUntil('/', (route) => false);
            },
          ),
        ],
      ),
    );
  }
}

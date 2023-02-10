import 'package:flutter/material.dart';
import 'package:wortra/services/auth.dart';

// ChatGPT code
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: Text(
                      'Name',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  Text(
                    '${AuthService().user!.displayName}',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 19.0),
                    child: Text(
                      'Email',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  Text(
                    '${AuthService().user!.email}',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
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
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:wortra/login/login.dart';
import 'package:wortra/services/auth.dart';
import 'package:wortra/workout/workout.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Text('loading'),
          );
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('error'),
          );
        } else if (snapshot.hasData) {
          return const WorkoutScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}

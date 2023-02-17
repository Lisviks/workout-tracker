import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wortra/login/login.dart';
import 'package:wortra/services/auth.dart';
import 'package:wortra/services/firestore.dart';
import 'package:wortra/services/models.dart';
import 'package:wortra/shared/nav_bar_handler.dart';
import 'package:wortra/state/workouts_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<List> getWorkouts(userId) async {
    List workouts = await DB().getWorkouts(userId);
    return workouts;
  }

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
          return FutureBuilder(
              future: getWorkouts(snapshot.data!.uid),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return ChangeNotifierProvider(
                    create: ((context) => WorkoutsState(
                        workouts: snapshot.data as List<Workout>)),
                    child: const NavBarHandler(),
                  );
                }
                // TODO: Loading screen
                return const Text('loading');
              }));
          // return const NavBarHandler();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}

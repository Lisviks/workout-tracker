import 'package:wortra/home/home.dart';
import 'package:wortra/profile/profile.dart';
import 'package:wortra/workout/workout.dart';

var appRoutes = {
  '/': (context) => const HomeScreen(),
  '/workout': (context) => const WorkoutScreen(),
  '/profile': (context) => const ProfileScreen(),
};

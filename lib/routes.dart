import 'package:wortra/history/history.dart';
import 'package:wortra/home/home.dart';
import 'package:wortra/profile/profile.dart';
import 'package:wortra/workout/add_workout.dart';
import 'package:wortra/workout/workout.dart';

var appRoutes = {
  '/': (context) => const HomeScreen(),
  '/workout': (context) => const WorkoutScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/add_workout': (context) => const AddWorkoutScreen(),
  '/history': (context) => const HistoryScreen(),
};

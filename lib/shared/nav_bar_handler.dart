import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wortra/history/history.dart';
import 'package:wortra/profile/profile.dart';
import 'package:wortra/workout/workout.dart';

class NavBarHandler extends StatefulWidget {
  const NavBarHandler({super.key});

  @override
  State<NavBarHandler> createState() => _NavBarHandlerState();
}

class _NavBarHandlerState extends State<NavBarHandler> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.dumbbell,
              size: 20,
            ),
            label: 'Workouts',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.circleUser,
              size: 20,
            ),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              FontAwesomeIcons.clockRotateLeft,
              size: 20,
            ),
            label: 'History',
          ),
        ],
        selectedItemColor: Colors.blueGrey[800],
        unselectedItemColor: Colors.blueGrey[300],
        currentIndex: index,
        onTap: (int x) {
          setState(() {
            index = x;
          });
        },
      ),
      body: IndexedStack(
        index: index,
        children: const [WorkoutScreen(), ProfileScreen(), HistoryScreen()],
      ),
    );
  }
}

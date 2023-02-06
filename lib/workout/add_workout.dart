import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wortra/services/auth.dart';
import 'package:wortra/services/firestore.dart';

class AddWorkoutScreen extends StatefulWidget {
  const AddWorkoutScreen({super.key});

  @override
  State<AddWorkoutScreen> createState() => _AddWorkoutScreenState();
}

class _AddWorkoutScreenState extends State<AddWorkoutScreen> {
  late TextEditingController _workoutNameController;
  late TextEditingController _incrementController;

  @override
  void initState() {
    super.initState();
    _workoutNameController = TextEditingController();
    _incrementController = TextEditingController();
  }

  @override
  void dispose() {
    _workoutNameController.dispose();
    _incrementController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Workout'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text('Workout Name', style: TextStyle(fontSize: 20.0)),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: TextField(
                controller: _workoutNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(fontSize: 20.0),
              ),
            ),
            const Text('Increment', style: TextStyle(fontSize: 20.0)),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
              child: TextField(
                controller: _incrementController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                style: const TextStyle(fontSize: 20.0),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
            ),
            SizedBox(
              width: 150.0,
              height: 50.0,
              child: ElevatedButton(
                onPressed: () => DB().addWorkout(_workoutNameController.text,
                    _incrementController.text, AuthService().user!.uid),
                child: const Text(
                  'Add',
                  style: TextStyle(fontSize: 20.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EditWorkoutDialog extends StatefulWidget {
  const EditWorkoutDialog({super.key, required this.workout});

  final Map workout;

  @override
  State<EditWorkoutDialog> createState() => _EditWorkoutDialogState();
}

class _EditWorkoutDialogState extends State<EditWorkoutDialog> {
  late TextEditingController _workoutNameController;
  late TextEditingController _incrementController;

  @override
  void initState() {
    super.initState();
    _workoutNameController = TextEditingController();
    _incrementController = TextEditingController();

    _workoutNameController.text = widget.workout['workoutName'];
    _incrementController.text = "${widget.workout['increment']}";
  }

  @override
  void dispose() {
    _workoutNameController.dispose();
    _incrementController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('Workout Name'),
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
            child: TextField(
              controller: _workoutNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
          const Text('Increment'),
          Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 20.0),
            child: TextField(
              controller: _incrementController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(fontSize: 16.0),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ),
          SizedBox(
            height: 50.0,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text(
                'Save',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
          )
        ],
      ),
    );
  }
}

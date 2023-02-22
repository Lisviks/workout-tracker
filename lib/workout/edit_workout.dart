import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wortra/shared/confirm_delete.dart';
import 'package:wortra/state/workout_state.dart';

class EditWorkoutDialog extends StatefulWidget {
  const EditWorkoutDialog({super.key, required this.workoutState});

  final WorkoutState workoutState;

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

    _workoutNameController.text = widget.workoutState.workout.workoutName;
    _incrementController.text = '${widget.workoutState.workout.increment}';
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
          const Text(
            'Workout Name',
            style: TextStyle(fontSize: 14.0),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
            child: TextField(
              controller: _workoutNameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(fontSize: 14.0),
            ),
          ),
          const Text(
            'Increment',
            style: TextStyle(fontSize: 14.0),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 12.0),
            child: TextField(
              controller: _incrementController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(fontSize: 14.0),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            ),
          ),
          SizedBox(
            height: 40.0,
            child: ElevatedButton(
              onPressed: () async {
                final NavigatorState navState =
                    context.findAncestorStateOfType<NavigatorState>() ??
                        Navigator.of(context);

                await widget.workoutState.editWorkout(
                  _workoutNameController.text,
                  int.parse(_incrementController.text),
                );

                navState.pop();
              },
              child: const Text(
                'Save',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: SizedBox(
              height: 40.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                onPressed: () async {
                  final NavigatorState navState =
                      context.findAncestorStateOfType<NavigatorState>() ??
                          Navigator.of(context);

                  navState.pop();
                  showDialog(
                    context: context,
                    builder: (context) => ConfirmDelete(
                      deleteMethod: () async {
                        final String id = widget.workoutState.workout.id;
                        final bool deleted =
                            widget.workoutState.workout.history.isEmpty
                                ? true
                                : false;
                        await widget.workoutState
                            .deleteWorkout(id: id, deleted: deleted);
                      },
                    ),
                  );
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

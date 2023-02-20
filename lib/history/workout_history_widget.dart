import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wortra/history/history_state.dart';
import 'package:wortra/services/history_model.dart';
import 'package:wortra/state/workouts_state.dart';

class WorkoutHistoryWidget extends StatelessWidget {
  const WorkoutHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final historyState = context.watch<HistoryState>();
    History history = historyState.history;
    final workoutsState = context.watch<WorkoutsState>();

    return ExpansionPanelList(
      expansionCallback: (index, isExpanded) {
        historyState.toggleList();
      },
      children: [
        ExpansionPanel(
            headerBuilder: ((context, isExpanded) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Text(history.workoutName),
                    IconButton(
                      onPressed: () => workoutsState.deleteHistory(history),
                      icon: const Icon(
                        Icons.delete_forever,
                        color: Colors.redAccent,
                      ),
                    ),
                  ],
                ),
              );
            }),
            body: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                children: workoutsState.workouts
                    .where((item) => item.workoutName == history.workoutName)
                    .toList()[0]
                    .history
                    .map<Widget>((e) {
                  final DateTime date =
                      DateTime.parse(e['date'].toDate().toString());
                  final int day = date.day;
                  final int month = date.month;
                  final int year = date.year;
                  final String formattedDate = '$year/$month/$day';

                  return Padding(
                    padding: const EdgeInsets.all(2.0),
                    child:
                        Text('$formattedDate - ${e['numberDone'].toString()}'),
                  );
                }).toList(),
              ),
            ),
            isExpanded: historyState.isOpen)
      ],
    );
  }
}

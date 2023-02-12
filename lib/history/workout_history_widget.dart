import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wortra/history/history_state.dart';

class WorkoutHistoryWidget extends StatelessWidget {
  const WorkoutHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final historyState = context.watch<HistoryState>();
    Map history = historyState.history;

    return ExpansionPanelList(
      expansionCallback: (index, isExpanded) {
        historyState.toggleList();
      },
      children: [
        ExpansionPanel(
            headerBuilder: ((context, isExpanded) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("${history['workoutName']}"),
              );
            }),
            body: Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                children: history['history'].map<Widget>((e) {
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

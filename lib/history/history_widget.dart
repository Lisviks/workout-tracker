import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wortra/history/history_model.dart';
import 'package:wortra/shared/confirm_delete.dart';
import 'package:wortra/state/workouts_state.dart';

class HistoryWidget extends StatefulWidget {
  const HistoryWidget({super.key, required this.history});

  final List<History> history;

  @override
  State<HistoryWidget> createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  @override
  Widget build(BuildContext context) {
    final List<History> history = widget.history;
    final workoutsState = context.watch<WorkoutsState>();

    return ExpansionPanelList(
      expansionCallback: (index, isExpanded) {
        setState(() {
          history[index].isExpanded = !history[index].isExpanded;
        });
      },
      children: history.map((item) {
        return ExpansionPanel(
          headerBuilder: ((context, isExpanded) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(item.workoutName),
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => ConfirmDelete(
                            deleteMethod: () =>
                                workoutsState.deleteHistory(item)),
                      );
                    },
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
                  .where((e) => e.workoutName == item.workoutName)
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
                  child: Text('$formattedDate - ${e['numberDone'].toString()}'),
                );
              }).toList(),
            ),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}

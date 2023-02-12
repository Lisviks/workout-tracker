import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wortra/history/history_state.dart';
import 'package:wortra/history/workout_history_widget.dart';
import 'package:wortra/services/auth.dart';
import 'package:wortra/services/firestore.dart';

// ChatGPT code
class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  Future<List> init() async {
    return await DB().getHistory(AuthService().user!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: FutureBuilder(
        future: init(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: [
                ...snapshot.data!
                    .map<Widget>(
                      (workout) => ChangeNotifierProvider(
                          create: (context) => HistoryState(history: workout),
                          child: const WorkoutHistoryWidget()),
                    )
                    .toList(),
              ],
            );
          }
          return const Text('Empty history');
        },
      ),
    );
  }
}

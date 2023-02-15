import 'package:flutter/material.dart';
import 'package:wortra/services/auth.dart';
import 'package:wortra/services/firestore.dart';

// ChatGPT code
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<List> getHistory() async {
    return DB().getHistory(AuthService().user!.uid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 16.0),
                    child: Text(
                      'Name',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  Text(
                    '${AuthService().user!.displayName}',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 19.0),
                    child: Text(
                      'Email',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ),
                  Text(
                    '${AuthService().user!.email}',
                    style: const TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Text(
                'Daily averages',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(
                height: 1.0,
                color: Colors.blueGrey,
              ),
            ),
            FutureBuilder(
                future: getHistory(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                        children: snapshot.data!.map((e) {
                      int total = 0;
                      List history = e['history'];
                      for (var val in history) {
                        total += val['numberDone'] as int;
                      }
                      String average =
                          (total / history.length).toStringAsFixed(2);

                      return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            children: [
                              Text(
                                '${e['workoutName']} - ',
                                style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(average),
                            ],
                          ));
                    }).toList());
                  }
                  return const Text('No workouts');
                }),
            ElevatedButton(
              child: const Text('signout'),
              onPressed: () async {
                final NavigatorState navState =
                    context.findAncestorStateOfType<NavigatorState>() ??
                        Navigator.of(context);
                await AuthService().signOut();
                navState.pushNamedAndRemoveUntil('/', (route) => false);
              },
            ),
          ],
        ),
      ),
    );
  }
}

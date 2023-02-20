import 'package:flutter/material.dart';

class ConfirmDelete extends StatelessWidget {
  const ConfirmDelete({super.key, required this.deleteMethod});

  final Function deleteMethod;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 10.0),
            child: Text('Are you sure?'),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                height: 40.0,
                child: ElevatedButton(
                  onPressed: () async {
                    final NavigatorState navState =
                        context.findAncestorStateOfType<NavigatorState>() ??
                            Navigator.of(context);

                    navState.pop();
                  },
                  child: const Text(
                    'No',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
              SizedBox(
                height: 40.0,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () async {
                    final NavigatorState navState =
                        context.findAncestorStateOfType<NavigatorState>() ??
                            Navigator.of(context);

                    deleteMethod();

                    navState.pop();
                  },
                  child: const Text(
                    'Delete',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

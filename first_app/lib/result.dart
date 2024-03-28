import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final VoidCallback restartHandler;

  Result(this.restartHandler);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text(
            "Well done",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          ElevatedButton(onPressed: restartHandler, child: Text('Restart')),
        ],
      ),
    );
  }
}

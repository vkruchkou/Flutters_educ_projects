import 'package:flutter/cupertino.dart';

class Quest extends StatelessWidget {
  final String questText;

  Quest(this.questText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
        margin: const EdgeInsets.all(10),
        child: Text(
      questText,
      style: const TextStyle(fontSize: 28),
      textAlign: TextAlign.center,
    ));
  }
}

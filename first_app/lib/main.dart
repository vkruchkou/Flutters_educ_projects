import './result.dart';
import 'package:flutter/material.dart';
import './quiz.dart';


void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  static const _questions = [
    {
      'questionText': 'question 1',
      'answers': ['Green', 'Black', 'White', 'Red']
    },
    {
      'questionText': 'question 2',
      'answers': ['Rabbit', 'Snake', 'Lion']
    }
  ];

  var _questionIndex = 0;

  void _answerQes() {
    setState(() {
      _questionIndex = _questionIndex + 1;
    });
  }

  void _restartQes() {
    setState(() {
      _questionIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('QuestionApp'),
        ),
        body: _questionIndex < _questions.length
            ? Quiz(answerQuestion: _answerQes,questions: _questions, questionIndex: _questionIndex,)
            : Result(_restartQes),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/answer.dart';
import './question.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final questions = const [
    {
      'questionText': 'what\'s your fav color?',
      'answer': ["black", "green", "red"]
    },
    {
      'questionText': 'what\'s your fav animal?',
      'answer': ["rabbit", "khers", "gav"]
    },
    {
      'questionText': 'what\'s your fav harchi?',
      'answer': ["rabbitq", "khersqq", "gavq"]
    }
  ];
  var _questionIndex = 0;

  void _naswerQuestions() {
    setState(() {
      _questionIndex = _questionIndex + 1;
    });

    print(_questionIndex);
    if (_questionIndex < questions.length) {
      print("hi");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Shimaaaaa is awesome!'),
          ),
          body: Column(
            children: [
              Question(
                questions[_questionIndex]['questionText'],
              ),
              ...(questions[_questionIndex]['answer'] as List<String>)
                  .map((answer) {
                return Answer(_naswerQuestions, answer);
              }).toList()
            ],
          )),
    );
  }
}

import 'package:flutter/material.dart';

void main() => runApp(myApp());

class myApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Shimaaaaa is awesome!'),
          ),
          body: Text('Dart and flutter is awesome!')),
    );
  }
}

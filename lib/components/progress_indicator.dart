import 'package:flutter/material.dart';

class MyProgressIndicator extends StatefulWidget {
  @override
  _MyProgressIndicatorState createState() => _MyProgressIndicatorState();
}

class _MyProgressIndicatorState extends State<MyProgressIndicator> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: LinearProgressIndicator(
        minHeight: 10,
      ),
    );
  }
}
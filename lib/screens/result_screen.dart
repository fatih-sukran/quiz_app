import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:quiz_app/chart/result_chart.dart';
import 'package:quiz_app/chart/result_data.dart';

class ResultScreen extends StatefulWidget {
  static const route = '/resultScreen';
  final int trues;
  final int falses;
  ResultScreen(this.trues, this.falses);
  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sonuç")),
      body: Container(
        color: Colors.lightBlueAccent,
        child: Column(
          children: [
            Expanded(child: Lottie.asset("assets/lotties/result.json")),
            Expanded(
              child: ResultChart(
                [
                  Results("Doğru", widget.trues),
                  Results("Yanlış", widget.falses),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 8.0, bottom: 16.0),
              child: RaisedButton(
                padding: EdgeInsets.only(
                  top: 16.0,
                  bottom: 16.0,
                  left: 32.0,
                  right: 32.0,
                ),
                child: Text(
                  "Ana Sayfa",
                  style: TextStyle(
                    fontSize: 21,
                    color: Colors.white,
                  ),
                ),
                color: Colors.blueAccent,
                onPressed: () => {
                  Navigator.pushReplacementNamed(
                    context,
                    '/',
                  )
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:quiz_app/chart/result_data.dart';

class ResultChart extends StatelessWidget {
  final List<Results> data;

  ResultChart(this.data);

  _getSeriesData() {
    List<charts.Series<Results, String>> series = [
      charts.Series(
          id: "Grades",
          data: data,
          labelAccessorFn: (Results row, _) => '${row.type}: ${row.value}',
          domainFn: (Results grades, _) => grades.type,
          measureFn: (Results grades, _) => grades.value)
    ];
    return series;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      padding: EdgeInsets.all(10),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Text(
                "Puanınız : ${data[0].value * 10 - data[1].value * (2.5)}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: charts.PieChart(
                  _getSeriesData(),
                  animate: true,
                  defaultRenderer: charts.ArcRendererConfig(
                      arcWidth: 60,
                      arcRendererDecorators: [charts.ArcLabelDecorator()]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

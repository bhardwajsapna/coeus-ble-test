import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class StackedLineChart extends StatelessWidget {
  final List<charts.Series<dynamic, int>> seriesList;
  final bool animate;

  StackedLineChart(this.seriesList, {this.animate = false});

  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(seriesList,
        animate: animate,
        defaultRenderer: new charts.LineRendererConfig(includePoints: true));
  }
}

/// Create series list with multiple series

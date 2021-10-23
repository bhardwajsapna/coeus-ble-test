import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class StackedLineChart extends StatelessWidget {
  final List<charts.Series<dynamic, int>> seriesList;
  final bool animate;
  final int minY, maxY;

  StackedLineChart(this.seriesList,
      {this.animate = false, this.minY = 0, this.maxY = 100});

  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(seriesList,
        animate: animate,
        defaultRenderer: new charts.LineRendererConfig(includePoints: true),
        primaryMeasureAxis: new charts.NumericAxisSpec(
            viewport: new charts.NumericExtents(this.minY, this.maxY)));
  }
}

/// Create series list with multiple series

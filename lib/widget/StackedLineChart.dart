import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class StackedLineChart extends StatelessWidget {
  final ndays;
  final List<charts.Series<dynamic, int>> seriesList;
  final bool animate;
  final int minY, maxY;

  StackedLineChart(this.seriesList,
      {this.animate = false, this.minY = 0, this.maxY = 100, this.ndays});

  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(
      seriesList,
      animate: animate,
      defaultRenderer: new charts.LineRendererConfig(includePoints: true),
      // defaultRenderer:
      // new charts.LineRendererConfig(includeArea: true, stacked: true),
      primaryMeasureAxis: new charts.NumericAxisSpec(
          viewport: new charts.NumericExtents(this.minY, this.maxY),
          tickProviderSpec:
              new charts.BasicNumericTickProviderSpec(desiredMinTickCount: 5)),
      domainAxis: new charts.NumericAxisSpec(
          viewport: new charts.NumericExtents(1, ndays),
          tickProviderSpec:
              new charts.BasicNumericTickProviderSpec(desiredMinTickCount: 5)),
    );
  }
}

/// Create series list with multiple series

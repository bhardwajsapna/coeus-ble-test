import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class StackedBarChart extends StatelessWidget {
  final List<charts.Series<dynamic, int>> seriesList;
  final bool animate;

  StackedBarChart(this.seriesList, {
    this.animate = false
  });

  /// Creates a stacked [BarChart] with sample data and no transition.
//  factory StackedBarChart.withSampleData() {
//    return new StackedBarChart(
//      _createSampleData(),
//      // Disable animations for image tests.
//      animate: false,
//    );
//  }

  // EXCLUDE_FROM_GALLERY_DOCS_START
  // This section is excluded from being copied to the gallery.
  // It is used for creating random series data to demonstrate animation in
  // the example app only.

  // EXCLUDE_FROM_GALLERY_DOCS_END

  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(
            seriesList,
            animate:animate,
        defaultRenderer:
        new charts.LineRendererConfig(includePoints: true)
    );
  }
}

/// Create series list with multiple series

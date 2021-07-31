import 'package:coeus_v1/models/BioValues.dart';
import 'package:coeus_v1/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter/services.dart' show rootBundle;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:async';

class Detailed_Card extends StatefulWidget {
  @override
  _Detailed_CardState createState() => _Detailed_CardState();
}

class _Detailed_CardState extends State<Detailed_Card> {
  BioValues? chartData;
  ChartSeriesController? _chartSeriesController;
  List<Point>? data;
  int count = 0;
  String key = 'ecg';
  List<int>? key_data;
  //Timer? timer;

  Future loadSalesData() async {
    final String jsonString = await getJsonFromAssets();
    chartData = bioValuesFromJson(jsonString);
    data = get_data(key);
    count = data!.length;
    key_data = chartData!.medicalValues![key];
   // timer = Timer.periodic(const Duration(milliseconds: 10), addChartData);
  }

  Future<String> getJsonFromAssets() async {
    return await rootBundle.loadString('assets/data.json');
  }

  @override
  void initState() {
    super.initState();
    loadSalesData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  // void addChartData(Timer timer) {
  //   setState(() {
  //     data!.removeAt(0);
  //     data!.add(Point(
  //         timestamp: count.toString(), value: key_data!.elementAt(count)));
  //     count = count + 1;
  //   });
  // }

  List<Point> get_data(key) {
    final data = chartData!.medicalValues![key];
    final duration = chartData!.duration;
    final sampling = chartData!.samplingInfo![key];
    List<Point> l = [];
    for (int i = 0; i < 50; i++) {
      l.add(Point(timestamp: i.toString(), value: data![i]));
    }
    print(l.length);
    return l;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Syncfusion Flutter chart'),
        ),
        body: Column(
          children: [
            Container(
              height: 300,
              child: FutureBuilder(
                  future: getJsonFromAssets(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SfCartesianChart(
                          primaryXAxis: CategoryAxis(),
                          // Chart title
                          title: ChartTitle(text: 'Data plotting'),
                          series: <ChartSeries<Point, String>>[
                            LineSeries<Point, String>(
                              onRendererCreated:
                                  (ChartSeriesController controller) {
                                _chartSeriesController = controller;
                              },
                              dataSource: data!,
                              xValueMapper: (Point p, _) => p.timestamp,
                              yValueMapper: (Point p, _) => p.value,
                            )
                          ]);
                    } else {
                      return Card(
                        elevation: 5.0,
                        child: Container(
                          height: 100,
                          width: 400,
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text('Retriving JSON data...',
                                    style: TextStyle(fontSize: 20.0)),
                                Container(
                                  height: 40,
                                  width: 40,
                                  child: CircularProgressIndicator(
                                    semanticsLabel: 'Retriving JSON data',
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.blueAccent),
                                    backgroundColor: Colors.grey[300],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }
                  }),
            ),
            Button(
              onTapFunction: () => {Navigator.pop(context)},
              title: "OK",
              width: MediaQuery.of(context).size.width,
            )
          ],
        ));
  }
}

class Point {
  String timestamp;
  int value;
  Point({required this.timestamp, required this.value});
}

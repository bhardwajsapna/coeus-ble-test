import 'dart:collection';

import 'package:coeus_v1/models/BioValues.dart';
import 'package:coeus_v1/models/TempValue.dart';
import 'package:coeus_v1/widget/StackedBarChart.dart';
import 'package:coeus_v1/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/services.dart' show rootBundle;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:async';

class Detailed_Card extends StatefulWidget {
  @override
  _Detailed_CardState createState() => _Detailed_CardState();
}

class _Detailed_CardState extends State<Detailed_Card> {
  Temperature? chartData;
  ChartSeriesController? _chartSeriesController;
  late List<Temprature> listdata;
  late Map<int, List<Temprature>> listMap = HashMap();
  int count = 0;
  String key = 'samples';
  List<int>? key_data;
  Timer? timer;
  List<charts.Series<Temprature, int>> seriesList = [];

  Future loadSalesData() async {
    /*
    22 aug - check the button which has called this page. Accordingly the file will be called.
    should graph show 1 day or 1 month.?  
    */
    final String jsonString = await getJsonFromAssets();
    chartData = welcomeFromJson(jsonString);

    seriesList.add(new charts.Series<Temprature, int>(
      id: 'Temprature',
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      domainFn: (Temprature temp, _) => temp.point,
      measureFn: (Temprature temp, _) => temp.temperature,
      data: get_data(),
    )
    );
    seriesList.add(new charts.Series<Temprature, int>(
      id: 'Temprature',
      colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
      domainFn: (Temprature temp, _) => temp.point,
      measureFn: (Temprature temp, _) => temp.temperature,
      data: get_dataMin(),
    )
    );
  }

  Future<String> getJsonFromAssets() async {
    return await rootBundle.loadString('assets/tempRecords.json');
  }

  @override
  void initState() {
    super.initState();
    loadSalesData();
  }


  List<Temprature> get_data() {
    List<Temprature> l = [];
    for (int i = 0; i < chartData!.tempValues.length; i++) {
      final data = chartData!.tempValues[i];
      int max = 0;
      if (data.samples != null && data.samples.isNotEmpty) {
        data.samples.sort((a, b) => a.temp.compareTo(b.temp));
        max = data.samples.last.temp;
      }

      l.add(Temprature(temperature: max, point: i));

      print(l.length);
    }
    return l;
  }

  List<Temprature> get_dataMin() {
    List<Temprature> l = [];
    for (int i = 0; i < chartData!.tempValues.length; i++) {
      final data = chartData!.tempValues[i];
      int min = 0;
      if (data.samples != null && data.samples.isNotEmpty) {
        data.samples.sort((a, b) => a.temp.compareTo(b.temp));
        min = data.samples.first.temp;
      }

      l.add(Temprature(temperature: min, point: i));

      print(l.length);
    }
    return l;
  }

      @override
      Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
              title: const Text('Data Chart'),
            ),
            body: Column(
              children: [
                Container(
                  height: 300,
                  child: FutureBuilder(
                      future: getJsonFromAssets(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return SizedBox(
                              height: 400.0,
                              child: StackedBarChart(
                                  seriesList, animate: false));
                          // return SfCartesianChart(
                          //     primaryXAxis: CategoryAxis(),
                          //     // Chart title
                          //     title: ChartTitle(text: 'Data plotting'),
                          //     series: <ChartSeries<Point, String>>[
                          //       LineSeries<Point, String>(
                          //         onRendererCreated:
                          //             (ChartSeriesController controller) {
                          //           _chartSeriesController = controller;
                          //         },
                          //         dataSource: data!,
                          //         xValueMapper: (Point p, _) => p.timestamp,
                          //         yValueMapper: (Point p, _) => p.value,
                          //       )
                          //     ]);
                        } else {
                          return Card(
                            elevation: 5.0,
                            child: Container(
                              height: 100,
                              width: 400,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceAround,
                                  children: [
                                    Text('Retriving JSON data...',
                                        style: TextStyle(fontSize: 20.0)),
                                    Container(
                                      height: 40,
                                      width: 40,
                                      child: CircularProgressIndicator(
                                        semanticsLabel: 'Retriving JSON data',
                                        valueColor: AlwaysStoppedAnimation<
                                            Color>(
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
                /*
            ns on 08 aug 21
            these buttons were added so that the content of the graph can be changed as per user request
            update the graph
            */
                Button(
                  onTapFunction: () => {Navigator.pop(context)},
                  title: "1 Day",
                  // width: 40,
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                ),
                Button(
                  onTapFunction: () => {Navigator.pop(context)},
                  title: "7 Days",
                  //width: 25, // this has tobe dne approrrri
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                ),
                /* Button(
              onTapFunction: () => {Navigator.pop(context)},
              title: "15 Day",
              width: MediaQuery.of(context).size.width,
            ),
            */
                Button(
                  onTapFunction: () => {Navigator.pop(context)},
                  title: "1 Month",
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                ),
                /* Button(
              onTapFunction: () => {Navigator.pop(context)},
              title: "OK",
              width: MediaQuery.of(context).size.width,
            )
            */
              ],
            ));
      }
    }




class Temprature {
  int temperature;
  int  point;

  Temprature({required this.temperature, required this.point});
}

import 'dart:collection';

import 'package:coeus_v1/models/BioValues.dart';
import 'package:coeus_v1/models/TempValue.dart';
import 'package:coeus_v1/widget/SimpleBarChart.dart';
import 'package:coeus_v1/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/services.dart' show rootBundle;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:async';

import '../models/MonthReadingOnceADay.dart';
import '../widget/StackedLineChart.dart';

class DetailedCardBar extends StatefulWidget {
  final String title;
  DetailedCardBar({
    required this.title,
  });
  @override
  _DetailedCardBarState createState() => _DetailedCardBarState();
}

class _DetailedCardBarState extends State<DetailedCardBar> {
  MonthReadingOnceADay? chartData;

  ChartSeriesController? _chartSeriesController;
  late List<Sensor> listdata;
  late Map<int, List<Sensor>> listMap = HashMap();
  int count = 0;
  String key = 'samples';
  List<int>? key_data;
  Timer? timer;
  List<charts.Series<Sensor, String>> seriesBarList = [];

  Future loadDataFromJson() async {
    final String jsonString = await getJsonFromAssets();
    chartData = convertJsonToMonthReadingOnceADay(jsonString);
    loadSensorData(30);
  }

  Future loadSensorData(int days) async {
    /*
    22 aug - check the button which has called this page. Accordingly the file will be called.
    should graph show 1 day or 1 month.?  
    */
    seriesBarList.add(new charts.Series<Sensor, String>(
      id: 'BarChart',
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      domainFn: (Sensor temp, _) => temp.point.toString(),
      measureFn: (Sensor temp, _) => temp.value,
      data: get_data(days),
    ));
  }

  Future<String> getJsonFromAssets() async {
    String fileName = "";
    switch (widget.title) {
      case "Temperature":
        fileName = 'assets/tempRecords.json';
        break;
      case "SpO2":
        fileName = 'assets/spo2Records.json';
        break;
      case "Heart Rate":
        fileName = 'assets/bpmRecords.json';
        break;
      case "ECG":
        fileName = 'assets/tempRecords.json';
        break;
      case "Footsteps":
      case "Sleep":
        fileName = 'assets/stepsSleepRecords.json';
        break;

      default:
        fileName = 'assets/tempRecords.json';
    }
    return await rootBundle.loadString(fileName);
  }

  @override
  void initState() {
    super.initState();
    loadDataFromJson();
    // loadSensorData(29);
  }

  List<Sensor> get_data(int days) {
    List<Sensor> l = [];
    for (int i = 0; //math.max(0, chartData!.tempValues.length - days - 1);
        i < chartData!.dayValues.length;
        i++) {
      final data = chartData!.dayValues[i];
      l.add(Sensor(value: data.stepsCount, point: i));
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
                          child: SimpleBarChart(seriesBarList, animate: false));
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
            /*
            ns on 08 aug 21
            these buttons were added so that the content of the graph can be changed as per user request
            update the graph
            */

            /*
            1 , 7 15 => title , no ofdays
            1 day by default for title , 1
            */
            Button(
              onTapFunction: () => loadSensorData(1),
              title: "1 Day",
              // width: 40,
              width: MediaQuery.of(context).size.width,
            ),
            Button(
              onTapFunction: () => loadSensorData(7),
              title: "7 Days",
              //width: 25, // this has tobe dne approrrri
              width: MediaQuery.of(context).size.width,
            ),
            /* Button(
              onTapFunction: () => {Navigator.pop(context)},
              title: "15 Day",
              width: MediaQuery.of(context).size.width,
            ),
            */
            Button(
              onTapFunction: () => loadSensorData(30),
              title: "1 Month",
              width: MediaQuery.of(context).size.width,
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

class Sensor {
  int value;
  int point;

  Sensor({required this.value, required this.point});
}

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

import '../widget/StackedLineChart.dart';

class Detailed_Card extends StatefulWidget {
  final String title;
  Detailed_Card({
    required this.title,
  });
  @override
  _Detailed_CardState createState() => _Detailed_CardState();
}

class _Detailed_CardState extends State<Detailed_Card> {
  MonthReading? chartData;

  ChartSeriesController? _chartSeriesController;
  late List<Sensor> listdata;
  late Map<int, List<Sensor>> listMap = HashMap();
  int count = 0;
  String key = 'samples';
  List<int>? key_data;
  Timer? timer;
  List<charts.Series<Sensor, int>> seriesList = [];
  bool isfirstLoading = true;
  int ndays = 7;

  Future loadDataFromJson() async {}

  Future loadSensorData(int days) async {
    /*
    22 aug - check the button which has called this page. Accordingly the file will be called.
    should graph show 1 day or 1 month.?  
    */
    final String jsonString = await getJsonFromAssets();

    chartData = convertJsonToTemp(jsonString);

    //setState(() {
    seriesList.add(new charts.Series<Sensor, int>(
      id: 'Temprature',
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      domainFn: (Sensor temp, _) => temp.point,
      measureFn: (Sensor temp, _) => temp.value,
      data: get_data(days),
    ));
    seriesList.add(new charts.Series<Sensor, int>(
      id: 'Temprature',
      colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
      domainFn: (Sensor temp, _) => temp.point,
      measureFn: (Sensor temp, _) => temp.value,
      data: get_dataMin(days),
    ));
    //  });
  }

  Future<String> getJsonFromAssets() async {
    String fileName = "";
    switch (widget.title) {
      case "Temperature":
        fileName = 'assets/tempRecords.json';
        break;
      case "SPo2":
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

  dynamic render_chart(int ndays) async {
    if (true) {
      //(isfirstLoading) {
      String fileName = "";
      switch (widget.title) {
        case "Temperature":
          fileName = 'assets/tempRecords.json';
          break;
        case "SPo2":
          fileName = 'assets/spo2Records.json';
          break;
        case "Heart Rate":
          fileName = 'assets/bpmRecords.json';
          break;
        case "ECG":
          fileName = 'assets/tempRecords.json';
          break;
        default:
          fileName = 'assets/tempRecords.json';
      }
      String jsonData = await rootBundle.loadString(fileName);
      // setState(() {
      chartData = convertJsonToTemp(jsonData);
      isfirstLoading = false;
      // });
    }
    // setState(() {
    seriesList = [];
    seriesList.add(new charts.Series<Sensor, int>(
      id: 'LineGraph',
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      domainFn: (Sensor temp, _) => temp.point,
      measureFn: (Sensor temp, _) => temp.value,
      data: get_data(ndays),
    ));
    seriesList.add(new charts.Series<Sensor, int>(
      id: 'LineGraph',
      colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
      domainFn: (Sensor temp, _) => temp.point,
      measureFn: (Sensor temp, _) => temp.value,
      data: get_dataMin(ndays),
    ));
    // });
    return seriesList;
  }

  @override
  void initState() {
    super.initState();
    // loadDataFromJson();
    loadSensorData(7);
  }

  List<Sensor> get_data(int days) {
    List<Sensor> l = [];
    for (int i = 0; //math.max(0, chartData!.tempValues.length - days - 1);
        i < days; //chartData!.tempValues.length;
        i++) {
      final data = chartData!.tempValues[i];
      int max = 0;
      if (data.samples != null && data.samples.isNotEmpty) {
        data.samples.sort((a, b) => a.temp.compareTo(b.temp));
        max = data.samples.last.temp;
      }
      l.add(Sensor(value: max, point: 30 - i));
      print(l.length);
    }
    return l;
  }

  List<Sensor> get_dataMin(int days) {
    List<Sensor> l = [];
    for (int i = math.max(0, chartData!.tempValues.length - days);
        i < chartData!.tempValues.length;
        i++) {
      final data = chartData!.tempValues[i];
      int min = 0;
      if (data.samples != null && data.samples.isNotEmpty) {
        data.samples.sort((a, b) => a.temp.compareTo(b.temp));
        min = data.samples.first.temp;
      }
      l.add(Sensor(value: min, point: 30 - i));
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
                  future: render_chart(ndays),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SizedBox(
                          height: 400.0,
                          child: StackedLineChart(seriesList, animate: false));
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
              onTapFunction: () => {
                setState(() {
                  ndays = 7;
                })
              },
              title: "7 Days",
              width: MediaQuery.of(context).size.width,
            ),
            Button(
              onTapFunction: () => {
                setState(() {
                  ndays = 15;
                })
              },
              title: "15 Days",
              width: MediaQuery.of(context).size.width,
            ),
            Button(
              onTapFunction: () => {
                setState(() {
                  ndays = 30;
                })
              },
              title: "1 Month",
              width: MediaQuery.of(context).size.width,
            ),
            Button(
              onTapFunction: () => {Navigator.pop(context)},
              title: "Done",
              width: MediaQuery.of(context).size.width,
            )
          ],
        ));
  }
}

class Sensor {
  int value;
  int point;

  Sensor({required this.value, required this.point});
}

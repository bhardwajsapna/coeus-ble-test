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
  int count = 0;
  String key = 'samples';
  List<int>? key_data;
  Timer? timer;
   List<charts.Series<Temprature, String>> seriesList=[];

  Future loadSalesData() async {
    final String jsonString = await getJsonFromAssets();
    chartData = welcomeFromJson(jsonString);
    listdata = get_data(key);
    count = listdata.length;


    seriesList = [
      new charts.Series<Temprature, String>(
        id: 'Temprature',
        domainFn: (Temprature sales, _) => sales.time,
        measureFn: (Temprature sales, _) => sales.temperature,
        data: listdata,
    )
    ];


    //key_data = chartData!.tempValues![key].sampleDate;
    //timer = Timer.periodic(const Duration(milliseconds: 10), addChartData);
  }

  Future<String> getJsonFromAssets() async {
    return await rootBundle.loadString('assets/tempRecords.json');
  }

  @override
  void initState() {
    super.initState();
    loadSalesData();
  }

  // void addChartData(Timer timer) {
  //   setState(() {
  //     data!.removeAt(0);
  //     data!.add(Point(
  //         timestamp: count.toString(), value: key_data!.elementAt(count)));
  //     count = count + 1;
  //   });
  // }

  List<Temprature> get_data(String key) {
    final data = chartData!.tempValues[0];


    List<Temprature> l = [];
    for (int i = 0; i < data.samples.length; i++) {
      l.add(Temprature(temperature: data.samples[i].temp, time: data.samples[i].time));
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
                      return SizedBox(
                          height: 400.0,
                          child: StackedBarChart(seriesList,animate:false));
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

class Temprature {
  int temperature;
  String time;

  Temprature({required this.temperature, required this.time});
}

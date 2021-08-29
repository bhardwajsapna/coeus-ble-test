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
  late Map<int,List<Temprature>> listMap = HashMap();
  int count = 0;
  String key = 'samples';
  List<int>? key_data;
  Timer? timer;
   List<charts.Series<Temprature, int>> seriesList=[];

  Future loadSalesData() async {
    final String jsonString = await getJsonFromAssets();
    chartData = welcomeFromJson(jsonString);
   // listdata = get_data(key);
   //  for(int i=0;i<chartData!.tempValues.length;i++){
   //  listMap.putIfAbsent(i, () => get_data(i));
   //  }

    //count = listdata.length;


    // seriesList = [
    //   new charts.Series<Temprature, String>(
    //     id: 'Temprature',
    //     domainFn: (Temprature sales, _) => sales.time,
    //     measureFn: (Temprature sales, _) => sales.temperature,
    //     data: listdata,
    // )
    // ];




    // for(int i=0;i<2;i++){

    seriesList.add( new charts.Series<Temprature,int>(
      id: 'Temprature',
      colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
      domainFn: (Temprature temp, _) => temp.point,
      measureFn: (Temprature temp, _) => temp.temperature,
      data: get_data(),
    )
    );
    // seriesList.add( new charts.Series<Temprature,int>(
    //   id: 'Temprature',
    //   colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
    //   domainFn: (Temprature temp, _) => temp.point,
    //   measureFn: (Temprature temp, _) => temp.temperature,
    //   data: get_data(),
    // )
    // );

   // }



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

  List<Temprature> get_data() {
    List<Temprature> l = [];
    for (int i = 0; i < chartData!.tempValues.length; i++) {
      final data = chartData!.tempValues[i];



      int max =0;
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



      int min =0;
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
  int  point;

  Temprature({required this.temperature, required this.point});
}

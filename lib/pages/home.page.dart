import 'dart:convert';
import 'dart:io';

import 'package:coeus_v1/components/summary_card.dart';
import 'package:coeus_v1/utils/const.dart';
import 'package:coeus_v1/utils/dashboard_secure_storage.dart';
import 'package:coeus_v1/utils/user_secure_storage.dart';

import 'package:coeus_v1/widget/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int batteryValue = 0;
  int footsteps = 0;
  double sleep = 0;
  int heartrate = 0;
  double temperature = 0;
  int spo2 = 0;
  String username = "User";
  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    username = await UserSecureStorage.getFirstName() ?? "User";
    batteryValue = await DashboardSecureStorage.getBattery();
    footsteps = await DashboardSecureStorage.getFootsteps();
    sleep = await DashboardSecureStorage.getSleep();
    heartrate = await DashboardSecureStorage.getHeartRate();
    spo2 = await DashboardSecureStorage.getSpO2();
    temperature = await DashboardSecureStorage.getTemperature();
    setState(() {
      this.batteryValue = batteryValue;
      this.footsteps = footsteps;
      this.sleep = sleep;
      this.heartrate = heartrate;
      this.spo2 = spo2;
      this.temperature = temperature;
      this.username = username;
    });
  }

  callAPI() {
    print("we are here ");
    debugPrint("yaarr");

    var url = "http://192.168.0.106:5000/userRegistration";
    Map jsonMap = {
      "firstName": "ss",
      "secondName": "ss",
      "DOB": {"date": "1995-02-20T18:30:00Z"},
      "mobileNo": "2121212121",
      "emergencyContact": {
        "firstName": "Shiva",
        "lastName": "kailash",
        "contactNumber": "1111111",
        "emailId": "sLs@kilasa.com"
      },
      "emailId": "sLs@kilasa.com",
      "gender": "Male",
      "password": "123",
      "doctorId": "123",
      "caretakerId": "333",
      "deviceId": "coeus_v1_777",
      "activeUser": true,
      "recordList": [
        {
          "creationDT": "26 Apr 95",
          "fullDT": "30 Apr 95",
          "recordName": "sree_r1"
        },
        {"creationDT": "30 Apr 95", "fullDT": "0", "recordName": "sree_r2"}
      ]
    };
    apiRequest(url, jsonMap);
  }

  Future<String> apiRequest(String url, Map jsonMap) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(jsonMap)));
    HttpClientResponse response = await request.close();
    // todo - you should check the response.statusCode
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    print(reply);
    return reply;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                margin: const EdgeInsets.only(left: 15.0),
                child: Text(
                  "Hello, " + username,
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                  ),
                ),
              ),
              SummaryCard(
                  image: AssetImage('assets/icons/Battery.png'),
                  value: "",
                  unit: "",
                  title: batteryValue.toString() + "%",
                  color: Constants.transparent),
            ],
          ),
          Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SummaryCard(
                        image: AssetImage('assets/icons/steps.png'),
                        title: "Footsteps",
                        value: this.footsteps.toString(),
                        unit: "steps",
                        color: Constants.lightBlue),
                    SizedBox(width: 10),
                    SummaryCard(
                        image: AssetImage('assets/icons/sleep.png'),
                        title: "Sleep",
                        value: this.sleep.toString(),
                        unit: "hours",
                        color: Constants.lightBlue),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SummaryCard(
                        image: AssetImage('assets/icons/heartbeat.png'),
                        title: "Heart Rate",
                        value: this.heartrate.toString(),
                        unit: "bpm",
                        color: Constants.lightBlue),
                    SizedBox(width: 10),
                    SummaryCard(
                        image: AssetImage('assets/icons/oxygen_.png'),
                        title: "SPo2",
                        value: this.spo2.toString(),
                        unit: "%",
                        color: Constants.lightBlue),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SummaryCard(
                        image: AssetImage('assets/icons/temperature.png'),
                        title: "Temperature",
                        value: this.temperature.toString(),
                        unit: "˚C",
                        color: Constants.lightBlue),
                    SizedBox(width: 10),
                    SummaryCard(
                        image: AssetImage('assets/icons/ECG.png'),
                        title: "ECG",
                        value: "??",
                        unit: "",
                        color: Constants.lightBlue),
                  ],
                ),
                /*  Row(
                  children: [
                    Button(
                      onTapFunction: callAPI,
                      title: "API Check",
                    )
                  ],
                ),*/
              ],
            ),
          ),
        ],
      ),
    );
  }

  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final desktopSalesData = [
      new OrdinalSales('2014', 5),
      new OrdinalSales('2015', 25),
      new OrdinalSales('2016', 100),
      new OrdinalSales('2017', 75),
    ];

    final tableSalesData = [
      new OrdinalSales('2014', 25),
      new OrdinalSales('2015', 50),
      new OrdinalSales('2016', 10),
      new OrdinalSales('2017', 20),
    ];

    final mobileSalesData = [
      new OrdinalSales('2014', 10),
      new OrdinalSales('2015', 15),
      new OrdinalSales('2016', 50),
      new OrdinalSales('2017', 45),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Desktop',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: desktopSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Tablet',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: tableSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Mobile',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: mobileSalesData,
      ),
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}



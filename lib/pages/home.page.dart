import 'package:coeus_v1/components/summary_card.dart';
import 'package:coeus_v1/utils/const.dart';
import 'package:coeus_v1/utils/dashboard_secure_storage.dart';
import 'package:coeus_v1/utils/user_secure_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Column(
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
                children: [
                  SummaryCard(
                      image: AssetImage('assets/icons/steps.png'),
                      title: "Footsteps",
                      value: this.footsteps.toString(),
                      unit: "steps",
                      color: Constants.transparent),
                  SizedBox(width: 10),
                  SummaryCard(
                      image: AssetImage('assets/icons/sleep.png'),
                      title: "Sleep",
                      value: this.sleep.toString(),
                      unit: "hours",
                      color: Constants.transparent),
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
            ],
          ),
        ),
      ],
    );
  }
}

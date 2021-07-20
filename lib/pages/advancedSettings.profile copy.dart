import 'dart:ffi';

import 'package:coeus_v1/utils/advanced_settings_secure_storage.dart';
import 'package:coeus_v1/utils/const.dart';
import 'package:coeus_v1/widget/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:coeus_v1/widget/button.dart';
import 'package:coeus_v1/widget/textLogin.dart';

class AdvancedSettingsProfilePage extends StatefulWidget {
  @override
  _AdvancedSettingsProfilePageState createState() =>
      _AdvancedSettingsProfilePageState();
}

class _AdvancedSettingsProfilePageState
    extends State<AdvancedSettingsProfilePage> {
  final ScrollController _scrollController = new ScrollController();

  List<String> communication_list = ["Only BLE", "Only Mobile", "Both"];
  List<String> samplingrate_list = ["256", "128", "512", "off"];

  int selected_index_comunication = 0;
  int selected_index_SpO2 = 0;
  int selected_index_ecg = 0;
  int selected_index_temp = 0;
  int selected_index_activity = 0;

  String selected_item_comunication = "";
  String selected_item_SpO2 = "";
  String selected_item_ecg = "";
  String selected_item_temp = "";
  String selected_item_activity = "";
  bool mounted = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //init();
    this.selected_item_comunication = communication_list[0];
    this.selected_item_SpO2 = samplingrate_list[0];
    this.selected_item_ecg = samplingrate_list[0];
    this.selected_item_temp = samplingrate_list[0];
    this.selected_item_activity = samplingrate_list[0];
  }

  int getIndexFromList(list, val) {
    print("hi...");
    print(list.indexOf(val));
    return list.indexOf(val);
  }

  Future init() async {
    if (!mounted) {
      print("HIIII");
      final communication =
          await AdvancedSettingsSecureStorage.getSamplingCommunication() ??
              communication_list[0];
      final spo2 = await AdvancedSettingsSecureStorage.getSamplingSpO2() ??
          samplingrate_list[0];
      final ecg = await AdvancedSettingsSecureStorage.getSamplingECG() ??
          samplingrate_list[0];
      final temp =
          await AdvancedSettingsSecureStorage.getSamplingTemperature() ??
              samplingrate_list[0];
      final activity =
          await AdvancedSettingsSecureStorage.getSamplingActivity() ??
              samplingrate_list[0];
      var data = [communication, spo2, ecg, temp, activity];
      setState(() {
        this.selected_index_comunication =
            getIndexFromList(communication_list, communication);
        this.selected_item_comunication = communication;

        this.selected_index_SpO2 = getIndexFromList(samplingrate_list, spo2);
        this.selected_item_SpO2 = spo2;

        this.selected_index_ecg = getIndexFromList(samplingrate_list, ecg);
        this.selected_item_ecg = ecg;

        this.selected_index_temp = getIndexFromList(samplingrate_list, temp);
        this.selected_item_temp = temp;

        this.selected_index_activity =
            getIndexFromList(samplingrate_list, activity);
        this.selected_item_activity = activity;
      });

      print(
          "selectedeindexactivity:" + this.selected_index_activity.toString());
      mounted = true;
      return data;
    }
  }

  void onSubmit() async {
    await AdvancedSettingsSecureStorage.setSamplingCommunication(
        this.selected_item_comunication);
    await AdvancedSettingsSecureStorage.setSamplingSpO2(
        this.selected_item_SpO2);
    await AdvancedSettingsSecureStorage.setSamplingECG(this.selected_item_ecg);
    await AdvancedSettingsSecureStorage.setSamplingTemperature(
        this.selected_item_temp);
    await AdvancedSettingsSecureStorage.setSamplingActivity(
        this.selected_item_activity);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Container(
          height: MediaQuery.of(context).size.height - 50,
          // decoration: BoxDecoration(
          //   gradient: LinearGradient(
          //       begin: Alignment.topRight,
          //       end: Alignment.bottomLeft,
          //       colors: [Constants.white, Constants.lightBlue]),
          // ),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                TextWrapper(
                  textstr: "Advanced Settings",
                  font: 32,
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height / 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            TextWrapper(textstr: "Device:", font: 24),
                            TextWrapper(textstr: "SpO2:", font: 24),
                            TextWrapper(textstr: "ECG:", font: 24),
                            TextWrapper(textstr: "Temperature:", font: 24),
                            TextWrapper(textstr: "Activity:", font: 24),
                          ],
                        ),
                      ),
                      FutureBuilder(
                          future: init(),
                          builder: (context, data) {
                            if (data.hasData) {
                              return Container(
                                height: MediaQuery.of(context).size.height / 2,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    DropDown(
                                        font: 22,
                                        dropdownItems: communication_list,
                                        selectedIndex:
                                            this.selected_index_comunication,
                                        onChangedValue: (item) => setState(() {
                                              // this.selected_index_comunication = index;
                                              this.selected_item_comunication =
                                                  item;
                                            })),
                                    DropDown(
                                        font: 22,
                                        dropdownItems: samplingrate_list,
                                        selectedIndex: this.selected_index_SpO2,
                                        onChangedValue: (item) => setState(() {
                                              // this.selected_index_SpO2 = index;
                                              this.selected_item_SpO2 = item;
                                            })),
                                    DropDown(
                                        font: 22,
                                        dropdownItems: samplingrate_list,
                                        selectedIndex: this.selected_index_ecg,
                                        onChangedValue: (item) => setState(() {
                                              // this.selected_index_ecg = index;
                                              this.selected_item_ecg = item;
                                            })),
                                    DropDown(
                                        font: 22,
                                        dropdownItems: samplingrate_list,
                                        selectedIndex: this.selected_index_temp,
                                        onChangedValue: (item) => setState(() {
                                              // this.selected_index_temp = index;
                                              this.selected_item_temp = item;
                                            })),
                                    DropDown(
                                        font: 22,
                                        dropdownItems: samplingrate_list,
                                        selectedIndex:
                                            this.selected_index_activity,
                                        onChangedValue: (item) => setState(() {
                                              // this.selected_index_activity = index;
                                              this.selected_item_activity =
                                                  item;
                                            })),
                                  ],
                                ),
                              );
                            } else {
                              return CircularProgressIndicator();
                            }
                          })
                    ],
                  ),
                ),
                Button(
                    title: "OK",
                    nextNavigation: null,
                    onTapFunction: onSubmit,
                    width: MediaQuery.of(context).size.width),
              ]),
        ),
      ]),
    );
  }
}

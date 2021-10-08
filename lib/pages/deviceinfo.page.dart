import 'dart:convert';

import 'package:coeus_v1/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:coeus_v1/widget/button.dart';
import 'package:coeus_v1/widget/textLogin.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DeviceInfoProfilePage extends StatefulWidget {
  @override
  _DeviceInfoProfilePageState createState() => _DeviceInfoProfilePageState();
}

class _DeviceInfoProfilePageState extends State<DeviceInfoProfilePage> {
  final ScrollController _scrollController = new ScrollController();

  String firmware_version = "0.0.0.0";
  String software_version = "0.0.0.0";
  List<BluetoothService> services = [];
  bool isReading = false;
  @override
  void initState() {
    FlutterBlue.instance.connectedDevices.then((value) async {
      List<BluetoothDevice> list = await value.toList();
      for (BluetoothDevice r in list) {
        if (r.name == 'ALISA') {
          services = await r.services.first;
          services.forEach((service) async {
            if (service.uuid.toString() ==
                "97fe6ff7-9e89-40ec-a371-2a2ea5b4d546") {
              print("found service...");

              var characteristics = service.characteristics;
              for (BluetoothCharacteristic c in characteristics) {
                if (c.uuid.toString() ==
                    "97fe0103-9e89-40ec-a371-2a2ea5b4d546") {
                  print("--------------------------------------");
                  print(c);
                  // // this is for reading the writen value...
                  if (!isReading) {
                    isReading = true;
                    c.read().then((value) {
                      firmware_version = utf8.decode(value);
                      print('value read : $firmware_version');
                      Fluttertoast.showToast(
                          msg: "$firmware_version",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0);
                    });
                    // isReading = false;
                  }
                }

                if (c.uuid.toString() ==
                    "97fe0104-9e89-40ec-a371-2a2ea5b4d546") {
                  print("--------------------------------------");
                  print(c);
                  // // this is for reading the writen value...
                  if (!isReading) {
                    isReading = true;
                    c.read().then((value) {
                      software_version = utf8.decode(value);
                      print('value read : $software_version');
                    });
                    // isReading = false;
                  }
                }
              }
            }
          });
        }
      }
    });
  }

  buttonOK() {
    Navigator.pop(context);
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
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(height: 20),
                TextWrapper(textstr: "Coeus v1.0", font: 36),
                SizedBox(height: 20),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextWrapper(textstr: "Serial No: XXX-XXX-XXX", font: 22),
                    TextWrapper(
                        textstr: "Firmware Version: $firmware_version",
                        font: 22),
                    TextWrapper(
                        textstr: "Software Version: $software_version",
                        font: 22),
                    TextWrapper(textstr: "Last Updated on MMDDYYYY", font: 22),
                    TextWrapper(textstr: "MAC Address: XXX-XXX-XXX", font: 22),
                  ],
                ),
                Button(
                    title: "OK",
                    nextNavigation: null,
                    onTapFunction: buttonOK,
                    width: MediaQuery.of(context).size.width),
              ]),
        ),
      ]),
    );
  }
}

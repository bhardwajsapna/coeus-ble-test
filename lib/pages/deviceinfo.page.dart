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

  String firmware_version = "1.0.1.4";
  String software_version = "1.2.1.0";
  List<BluetoothService> services = [];
  bool isReading = false;
  @override
  void initState() {
    FlutterBlue.instance.connectedDevices.then((value) async {
      List<BluetoothDevice> list = await value.toList();

      for (BluetoothDevice r in list) {
        var rname = r.name;
        Fluttertoast.showToast(
            msg: "inside COEUS For loop" + "$rname",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);

//        if (r.name == 'ALISA') {
        /*  if (r.name.contains('COEUS')) {
          Fluttertoast.showToast(
              msg: "finally done",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);

          services = await r.services.first;
          var servicesLst;
          services.forEach((element) {
            servicesLst = servicesLst + element.uuid.toString();
            servicesLst = servicesLst + "1";
          });
          Fluttertoast.showToast(
              msg: "$servicesLst",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        } else {
          Fluttertoast.showToast(
              msg: "compare not working",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
        }
*/

        if (r.name.contains('COEUS')) {
          Fluttertoast.showToast(
              msg: "inside COEUS = inside IF COEUS",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);

          //services = await r.services.contains("Unknown"); //.last;
          // var serviceLen = await r.services.length;
          var services = await r.discoverServices();

          services.forEach((element) {
            var temp = element.uuid;
            Fluttertoast.showToast(
                msg: "inside COEUS service LEN = $temp",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          });
          //.isEmpty; //.contains("Unknown");
          //services.length; //services.length.toString();
          Fluttertoast.showToast(
              msg: "inside COEUS service LEN = ${services.length}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);

          services.forEach((service) async {
            var serviceDispName = service.uuid.toString();
            Fluttertoast.showToast(
                msg: "$serviceDispName",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);

            if (service.uuid.toString() ==
                "97fe0100-9e89-00ec-2371-2a2ea5b4d546") {
              print("found service...");

              Fluttertoast.showToast(
                  msg: "COnnected to service 100",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);

              var characteristics = service.characteristics;
              for (BluetoothCharacteristic c in characteristics) {
                if (c.uuid.toString() ==
                    "97fe0103-9e89-00ec-2371-2a2ea5b4d546") {
                  // // this is for reading the writen value...
                  var tempVal = await c.read();
                  Fluttertoast.showToast(
                      msg: "value = " + "$tempVal",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);

                  firmware_version = utf8.decode(tempVal);
                  //21 oct 21
                  firmware_version = "1.0.1.1";
                  print('value read : $firmware_version');
                  Fluttertoast.showToast(
                      msg: "firmware Ver" + "$firmware_version",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }

                if (c.uuid.toString() ==
                    "97fe0104-9e89-00ec-2371-2a2ea5b4d546") {
                  // // this is for reading the writen value...
                  var tempValSW = await c.read();
                  Fluttertoast.showToast(
                      msg: "software value = " + "$tempValSW",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);

                  software_version = utf8.decode(tempValSW);
                  //21 oct 21
                  software_version = "1.1.2.1";
                  print('value read : $software_version');
                }

                if (c.uuid.toString() ==
                    "97fe0108-9e89-00ec-2371-2a2ea5b4d546") {
                  // // this is for reading the writen value...
                  var tempValSW = await c.read();
                  Fluttertoast.showToast(
                      msg: "adv setting  value = " + "$tempValSW",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);

                  software_version = utf8.decode(tempValSW);
                  print('value read : $software_version');
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
                    TextWrapper(textstr: "Serial No: 123-323-679", font: 22),
                    TextWrapper(
                        textstr: "Firmware Version: $firmware_version",
                        font: 22),
                    TextWrapper(
                        textstr: "Software Version: $software_version",
                        font: 22),
                    TextWrapper(
                        textstr: "Last Updated on:  10212021", font: 22),
                    TextWrapper(textstr: "MAC Address: 879-988-357", font: 22),
                  ],
                ),
                Button(
                  title: "OK",
                  nextNavigation: null,
                  onTapFunction: buttonOK,
                  width: MediaQuery.of(context).size.width,
                  baseColor: Constants.dull_move,
                ),
              ]),
        ),
      ]),
    );
  }
}

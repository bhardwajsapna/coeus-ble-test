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

  List bledata = [];
  late BluetoothCharacteristic ch213;
  bool isReading = false;
  @override
  void initState() {}

  buttonOK() {
    Navigator.pop(context);
  }

/*
04 nov 21 - done for demonstration of app - sreeni
*/

  displayOnScreen(String msg) {
    debugPrint(msg);
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  readDeviceInfo() {
    displayOnScreen("Demo reading");
    FlutterBlue.instance.connectedDevices.then((value) async {
      List<BluetoothDevice> list = await value.toList();

      displayOnScreen(
          "number of ble devices connected" + list.length.toString());
// instead of taking list of conncted devices we need to take COEUS.. for optimisation
//step 1: get the list of BLE devices
      for (BluetoothDevice r in list) {
        debugPrint("device @ name" + r.name);
//Step 2: get the COEUS device for communication
        if (r.name.contains(Constants.deviceName)) {
//step 3: Get the list of services of coeus
          var services = await r.discoverServices();

          displayOnScreen(
              "number of services in COEUS " + services.length.toString());
// step 4: iterate through all the services
          //  services.forEach((service) async {
          for (BluetoothService service in services) {
            displayOnScreen("service @ " + service.uuid.toString());

// step 5: look the for the required service
            if (service.uuid.toString() == Constants.service) {
// step 6: once you get the required services, get all the characteristics of this service
              var characteristics = service.characteristics;
              displayOnScreen(
                  "length of character @ " + characteristics.length.toString());
// step 7: iterate on all the characteristics of the service
              for (BluetoothCharacteristic c in characteristics) {
                displayOnScreen("character uuid @ " + c.uuid.toString());
                displayOnScreen(
                    "character serviceuuid@ " + c.serviceUuid.toString());
                displayOnScreen("character 2ndaryServiceUuid@ " +
                    c.secondaryServiceUuid.toString());

// step 8: from here on check for the required characteristic of a service to read or write the data
// step 8.1 : looking for firmware service to read the firmware version
                if (c.uuid.toString() == Constants.character104) {
                  ch213 = c;
                  displayOnScreen("in firmware read");
                  // // this is for reading the writen value...

                  // code for read
                  var tempVal = await c.read();
                  //  c.read().then((tempVal) =>
                  displayOnScreen("tempval data is " + tempVal.toString()); //);

                  /*         await c.setNotifyValue(true);
                  c.value.listen((tempVal) {
                    bledata.add(tempVal);
                    displayOnScreen("tempval data is " + tempVal.toString());
                  });
*/
                  // this code has been written like this as the version data is not utf8 encoded.
                  /*  setState(() {
                    firmware_version = "";
                    for (var tint in tempVal) {
                      firmware_version =
                          firmware_version + tint.toString() + ".";
                    }
                  });
*/
                  //21 oct 21
                  firmware_version = tempVal.toString();
                  displayOnScreen('firmware ver :  $firmware_version');
                }

// step 8.2 : looking for firmware service to read the software version
                /*            if (c.uuid.toString() == Constants.character104) {
                  // // this is for reading the writen value...
                  var tempValSW = await c.read();

                  displayOnScreen("in software version read");
                  // software_version = utf8.decode(tempValSW);
                  // this code has been written like this as the version data is not utf8 encoded.
                  setState(() {
                    software_version = "";
                    for (var tint in tempValSW) {
                      software_version =
                          software_version + tint.toString() + ".";
                    }
                  });
                  //21 oct 21
                  // software_version = "1.1.2.1";
                  displayOnScreen('software ver : $software_version');
                }*/
              }
            }
          } //);
        }
      }
    });
  }

  stopReading() {
    ch213.setNotifyValue(false);
    displayOnScreen("now stop reading");
    debugPrint(bledata.first.toString());
    debugPrint(bledata.last.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        Container(
          height: MediaQuery.of(context).size.height - 50,
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
                  title: "Demo",
                  nextNavigation: null,
                  onTapFunction: readDeviceInfo,
                  width: MediaQuery.of(context).size.width,
                  baseColor: Constants.dull_move,
                ),
                Button(
                  title: "Stop Reading",
                  nextNavigation: null,
                  onTapFunction: stopReading,
                  width: MediaQuery.of(context).size.width,
                  baseColor: Constants.dull_move,
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

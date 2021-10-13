import 'package:coeus_v1/widget/bluetoohSearch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DiscoveryBluetoothDevice extends StatefulWidget {
  _DiscoveryBluetoothDevice createState() => _DiscoveryBluetoothDevice();
}

class _DiscoveryBluetoothDevice extends State<DiscoveryBluetoothDevice> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  List<ScanResult> list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Start scanning
    flutterBlue.startScan();
    //flutterBlue.scan();

// Listen to scan results
    // ignore: cancel_subscriptions
    var subscription = flutterBlue.scanResults.listen((results) {
      // do something with scan results
      list = [];
      for (ScanResult r in results) {
        setState(() {
          list.add(r);
        });

        print('${r.device.name} found! rssi: ${r.rssi}');
      }
    });

    subscription.onDone(() {
      flutterBlue.stopScan();
    });

// Stop scanning
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: list.length,
        itemBuilder: (BuildContext context, index) {
          ScanResult result = list[index];
          final device = result.device;
          final address = device.id.id;
          return BluetoothDeviceListEntry(
            device: result.device,
            rssi: result.rssi,
            onTap: () async {
              Fluttertoast.showToast(
                  msg: "come for connection",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
              print("in tap...");
              await device.connect();
              if (BluetoothDeviceState.connected != null) {
                print("alisa-connected...");

                Fluttertoast.showToast(
                    msg: "connected",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            },
            onLongPress: () async {
              try {
                if (BluetoothDeviceState.connected != null) {
                  device.disconnect();
                  print("alisa-disconnected...");
                }
              } catch (ex) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Error occured while bonding'),
                      content: Text("${ex.toString()}"),
                      actions: <Widget>[
                        new TextButton(
                          child: new Text("Close"),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              }
            },
          );
        },
      ),
    );
  }
}

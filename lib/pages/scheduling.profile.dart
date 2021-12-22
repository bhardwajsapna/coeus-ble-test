import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:coeus_v1/utils/const.dart';
import 'package:coeus_v1/widget/inputEmail.dart';
import 'package:coeus_v1/widget/scroller.dart';
import 'package:coeus_v1/widget/time_picker.dart';
//import 'package:dio/dio.dart';
import 'package:direct_select/direct_select.dart';
import 'package:flutter/material.dart';
import 'package:coeus_v1/widget/button.dart';
import 'package:coeus_v1/widget/textLogin.dart';

import 'package:flutter_blue/flutter_blue.dart';
// import 'package:flutter_blue/gen/flutterblue.pb.dart';
import 'package:fluttertoast/fluttertoast.dart';

//import 'package:path_provider/path_provider.dart';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_nordic_dfu/flutter_nordic_dfu.dart';
import 'package:flutter_blue/flutter_blue.dart';

final key = new GlobalKey<CustomPickerPageState>();

class SchedulingProfilePage extends StatefulWidget {
  @override
  _SchedulingProfilePageState createState() => _SchedulingProfilePageState();
}

class _SchedulingProfilePageState extends State<SchedulingProfilePage> {
  final ScrollController _scrollController = new ScrollController();
  final controllerCharacteristicRead = TextEditingController();
  final controllerCharacteristicWrite = TextEditingController();
  late CustomPickerPage custom_picker;
  final elements = [1, 2, 3, 4, 5, 6];
  int selected_index = 3;

  var fileUrl = "http://192.168.173.49:5000/file/App_update.bin";
  bool downloading = true;
  String downloadingStr = "No data";
  String savePath = "";
  String sensorData = "";

  _getBLEData(String characteristic_given) {
    FlutterBlue.instance.connectedDevices.then((value) async {
      List<BluetoothDevice> list = await value.toList();

      for (BluetoothDevice r in list) {
        var rname = r.name;
        Fluttertoast.showToast(
            msg: "inside COEUS For **** loop" + "$rname",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);

        debugPrint("list of ble" + r.name);

        if (r.name.contains(Constants.deviceName)) {
          Fluttertoast.showToast(
              msg: "inside COEUS = inside IF **** COEUS",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);

          //services = await r.services.contains("Unknown"); //.last;
          // var serviceLen = await r.services.length;
          var services = await r.discoverServices();

          services.forEach((service) async {
            var serviceDispName = service.uuid.toString();

            if (service.uuid.toString() == Constants.service) {
              print("found service...");

              var characteristics = service.characteristics;
              for (BluetoothCharacteristic c in characteristics) {
                String full_char = Constants.characteristic_format;
                full_char = full_char.replaceAll('XXX', characteristic_given);
                debugPrint("print:fullchal" + full_char);
                if (c.uuid.toString() == full_char) {
                  // // this is for reading the writen value...
                  var tempVal = await c.read();
                  debugPrint("temp val = " + "$tempVal");
                  setState(() {
                    sensorData = tempVal.toString();
                  });
                }
              }
            }
          });
        }
      }
    });
  }

// 18 dec 21
// work during integration
  sendDateTime() {
    //BluetoothService ctsService = BluetoothService;
  }

  getBLEData(String characteristic_given) {
    Constants.bleDevice.discoverServices().then((services) {
      services.forEach((service) async {
        var serviceDispName = service.uuid.toString();
        print("print:servicename" + serviceDispName);
        if (service.uuid.toString() == Constants.service) {
          print("found service...");
          String full_char = Constants.characteristic_format;
          full_char = full_char.replaceAll('XXX', characteristic_given);
          debugPrint("print:fullchal" + full_char);
          var characteristics = service.characteristics;
          for (BluetoothCharacteristic c in characteristics) {
            print("print:char:" + c.uuid.toString());
            if (c.uuid.toString() == full_char) {
              // // this is for reading the writen value...
              var count = 0;
              while (count < 5) {
                var tempVal = await c.read();
                debugPrint("temp val = " + "$tempVal");
                setState(() {
                  sensorData = tempVal.toString();
                });
                count++;
              }
            }
          }
        }
      });
    });
  }

  listenBLEData(String characteristic_given) {
    Constants.bleDevice.discoverServices().then((services) {
      services.forEach((service) async {
        var serviceDispName = service.uuid.toString();
        print("print:servicename" + serviceDispName);
        if (service.uuid.toString() == Constants.service) {
          print("found service...");
          String full_char = Constants.characteristic_format;
          full_char = full_char.replaceAll('XXX', characteristic_given);
          debugPrint("print:fullchal" + full_char);
          var characteristics = service.characteristics;
          for (BluetoothCharacteristic c in characteristics) {
            print("print:char:" + c.uuid.toString());
            if (c.uuid.toString() == full_char) {
              // // this is for reading the writen value...
              var count = 0;
              //await Constants.bleDevice.requestMtu(100);
              await c.setNotifyValue(true);
              c.value.listen((value) {
                // do something with new value
                debugPrint("notified val = " + "$value");
                setState(() {
                  sensorData = value.toString();
                });
              });
            }
          }
        }
      });
    });
  }

  writeBLEData(String data, String characteristic_given) {
    Constants.bleDevice.discoverServices().then((services) {
      services.forEach((service) async {
        var serviceDispName = service.uuid.toString();

        if (service.uuid.toString() == Constants.service_100) {
          print("found service...");

          var characteristics = service.characteristics;
          for (BluetoothCharacteristic c in characteristics) {
            String full_char = Constants.characteristic_format;
            full_char = full_char.replaceAll('XXX', characteristic_given);
            debugPrint("print:fullchal" + full_char);
            if (c.uuid.toString() == full_char) {
              // // this is for reading the writen value...
              //final list = new Uint64List.fromList([int.parse(data)]);
              //final bytes = new Uint8List.view(list.buffer);

              // data_list = [];
              var tempVal = await c.write(utf8.encode(data));
              debugPrint("temp val = " + "$tempVal");
              setState(() {
                sensorData = tempVal.toString();
              });
            }
          }
        }
      });
    });
  }

  initiateBLEData(String characteristic_given) {
    Constants.bleDevice.discoverServices().then((services) {
      services.forEach((service) async {
        var serviceDispName = service.uuid.toString();

        if (service.uuid.toString() == Constants.service_100) {
          print("found service...");

          var characteristics = service.characteristics;
          for (BluetoothCharacteristic c in characteristics) {
            String full_char = Constants.characteristic_format;
            full_char = full_char.replaceAll('XXX', characteristic_given);
            debugPrint("print:fullchal" + full_char);
            if (c.uuid.toString() == full_char) {
              // // this is for reading the writen value...
              //final list = new Uint64List.fromList([int.parse(data)]);
              //final bytes = new Uint8List.view(list.buffer);

              // data_list = [];
              var tempVal = await c.write([1]);
              debugPrint("temp val = " + "$tempVal");
              setState(() {
                sensorData = tempVal.toString();
              });
            }
          }
        }
      });
    });
  }

  readSensorsData(characteristic_given) {
    var readFlagStatus;
    Constants.bleDevice.discoverServices().then((services) {
      services.forEach((service) async {
        var serviceDispName = service.uuid.toString();
        print("print:servicename" + serviceDispName);
        if (service.uuid.toString() == Constants.service) {
          print("found service...");
          String full_char = Constants.characteristic_format;
          String flag_char = full_char.replaceAll('XXX', '220');
          full_char = full_char.replaceAll('XXX', characteristic_given);
          debugPrint("print:fullchal" + full_char);
          late BluetoothCharacteristic flagC;
          late BluetoothCharacteristic dataC;
          var characteristics = service.characteristics;
          for (BluetoothCharacteristic c in characteristics) {
            print("print:char:" + c.uuid.toString());
            if (c.uuid.toString() == full_char) {
              dataC = c;
              print("foundC");
            }
            if (c.uuid.toString() == flag_char) {
              flagC = c;
              print("foundFlag");
              await flagC.setNotifyValue(true);
              print(flagC.value);
              flagC.value.listen((value) {
                setState(() {
                  readFlagStatus = value;
                  print("flagStatus" + readFlagStatus);
                });
              });
            }
            // // this is for reading the writen value...
            // var count = 0;
            // while (count < 5) {
            //   var tempVal = await c.read();
            //   debugPrint("temp val = " + "$tempVal");
            //   setState(() {
            //     sensorData = tempVal.toString();
            //   });
            //   count++;
            // }
          }

          while (true) {
            print("flagC:" + flagC.value.toString());
            if (readFlagStatus) {
              var tempVal = await dataC.read();
              debugPrint("temp val = " + "$tempVal");
              setState(() {
                sensorData = tempVal.toString();
              });
            }
          }
        }
      });
    });
  }

  // Future downloadFile() async {
  //   try {
  //     Dio dio = Dio();

  //     String fileName = fileUrl.substring(fileUrl.lastIndexOf("/") + 1);

  //     debugPrint("filename = " + fileName);

  //     savePath = await getFilePath(fileName);
  //     debugPrint("save path" + savePath);
  //     await dio.download(fileUrl, savePath, onReceiveProgress: (rec, total) {
  //       setState(() {
  //         downloading = true;
  //         // download = (rec / total) * 100;
  //         downloadingStr = "Downloading Image : $rec";
  //       });
  //     });
  //     setState(() {
  //       downloading = false;
  //       downloadingStr = "Completed";
  //       debugPrint("saved path =" + savePath);
  //       debugPrint("download " + downloadingStr);
  //       File binFile = new File(savePath);
  //       final bytes = binFile.readAsBytesSync().lengthInBytes;
  //       debugPrint("size of file is = " + bytes.toString());
  //     });
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  // Future<String> getFilePath(uniqueFileName) async {
  //   String path = '';

  //   Directory dir = await getApplicationDocumentsDirectory();

  //   path = '${dir.path}/$uniqueFileName';

  //   return path;
  // }

  // Future<void> doDfu(String deviceId) async {
  //   // stopScan();
  //   //dfuRunning = true;
  //   try {
  //     // deviceId,
  //     debugPrint("started uploading");
  //     var s = await FlutterNordicDfu.startDfu(
  //       'FB:36:25:8F:DC:4D',
  //       'assets/App_dfu.zip',
  //       fileInAsset: true,
  //       progressListener:
  //           DefaultDfuProgressListenerAdapter(onProgressChangedHandle: (
  //         deviceAddress,
  //         percent,
  //         speed,
  //         avgSpeed,
  //         currentPart,
  //         partsTotal,
  //       ) {
  //         print('deviceAddress: $deviceAddress, percent: $percent');
  //         debugPrint('deviceAddress: $deviceAddress, percent: $percent');
  //       }),
  //     );
  //     print(s);
  //     debugPrint(s);
  //     // dfuRunning = false;
  //   } catch (e) {
  //     // dfuRunning = false;
  //     print(e.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    var currentState = key.currentState;
    List<String> elements_str = elements.map((e) => e.toString()).toList();
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height - 50,
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //       begin: Alignment.topRight,
        //       end: Alignment.bottomLeft,
        //       colors: [Constants.white, Constants.lightBlue]),
        // ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              InputField(
                title: "char",
                font: 22,
                isPassword: false,
                controller: controllerCharacteristicRead,
                onChanged: (val) {
                  print("value changed:" + val);
                },
                validator: (String? value) {},
              ),
              Button(
                title: "Try Read",
                onTapFunction: () =>
                    {getBLEData(controllerCharacteristicRead.text)},
                width: MediaQuery.of(context).size.width,
                baseColor: Constants.lightgreendull,
              ),
              Button(
                title: "Try Notify",
                onTapFunction: () =>
                    {listenBLEData(controllerCharacteristicRead.text)},
                width: MediaQuery.of(context).size.width,
                baseColor: Constants.lightgreendull,
              ),
              TextWrapper(
                textstr: "Data Read:{$sensorData}",
                font: 18,
              ),
              InputField(
                title: "write something",
                font: 22,
                isPassword: false,
                controller: controllerCharacteristicWrite,
                onChanged: (val) {
                  print("value changed:" + val);
                },
                validator: (String? value) {},
              ),
              Button(
                title: "Try Write",
                onTapFunction: () =>
                    //{}
                    {writeBLEData(controllerCharacteristicWrite.text, '101')},
                width: MediaQuery.of(context).size.width,
                baseColor: Constants.lightgreendull,
              ),
              Button(
                title: "Write Date",
                onTapFunction: () {
                  DateTime now = DateTime.now();
                  String time_now = now.millisecondsSinceEpoch.toString();
                  print("time_now:" + time_now);
                  writeBLEData(time_now, '111');
                },
                width: MediaQuery.of(context).size.width,
                baseColor: Constants.lightgreendull,
              ),
              Button(
                title: "Initiate Sensor Read",
                onTapFunction: () =>
                    //{}
                    {initiateBLEData('110')},
                width: MediaQuery.of(context).size.width,
                baseColor: Constants.lightgreendull,
              ),

              Button(
                title: "Read Packet",
                onTapFunction: () => readSensorsData('201'),
                width: MediaQuery.of(context).size.width,
                baseColor: Constants.lightgreendull,
              ),
              // Button(
              //   title: "Download latest Firmware",
              //   onTapFunction: downloadFile,
              //   width: MediaQuery.of(context).size.width,
              //   baseColor: Constants.lightgreendull,
              // ),
              // Button(
              //   title: "Upload to Device",
              //   onTapFunction: () async {
              //     await this.doDfu("1"); //result.device.id.id);
              //   },
              //   width: MediaQuery.of(context).size.width,
              //   baseColor: Constants.lightgreendull,
              // )
            ],
          ),
        ),
      ),
    );
  }
}

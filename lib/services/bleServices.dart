import 'dart:convert';
import 'package:coeus_v1/utils/const.dart' as globalAccess;
import 'package:coeus_v1/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';

/*
*
*   Below are the BLE write functions 
*
*/

//base functions - as write is given in only characteristic 100 so this is coded accordingly
writeBLE_String_Data_service_100(String data, String characteristic_given) {
  debugPrint("come to write" + Constants.bleDevice.id);
  if (Constants.bleDevice != null) {
    String full_char = Constants.characteristic_format_100;

    full_char = full_char.replaceAll('XXX', characteristic_given);

    debugPrint(
        "writing to " + Constants.service_100 + " character " + full_char);
    final characteristic = QualifiedCharacteristic(
        serviceId: Uuid.parse(Constants.service_100),
        characteristicId: Uuid.parse(full_char),
        deviceId: Constants.bleDevice!.id);

    Constants.flutterReactiveBle.writeCharacteristicWithResponse(characteristic,
        value: utf8.encode(data));
  }
}

writeBLE_List_Data_service_100(List<int> data, String characteristic_given) {
  debugPrint("come to write" + Constants.bleDevice.id);
  if (Constants.bleDevice != null) {
    String full_char = Constants.characteristic_format_100;

    full_char = full_char.replaceAll('XXX', characteristic_given);

    debugPrint(
        "writing to " + Constants.service_100 + " character " + full_char);
    final characteristic = QualifiedCharacteristic(
        serviceId: Uuid.parse(Constants.service_100),
        characteristicId: Uuid.parse(full_char),
        deviceId: Constants.bleDevice!.id);

    Constants.flutterReactiveBle
        .writeCharacteristicWithResponse(characteristic, value: data);
  }
}

//user functions in application
//this is called when the app gets connected to device and also button press in test app
writeISTEpochTime() {
  DateTime now = DateTime.now();
  String time_now = (((now.millisecondsSinceEpoch) / 1000)).toStringAsFixed(0);
  print("time_now:" + time_now);
  writeBLE_String_Data_service_100(time_now, '112');
}

// this is called when the user press the "sync" button on the dash board
initiateBLEData(String characteristic_given) {
  writeBLE_List_Data_service_100([1], characteristic_given);
}

/*
*
*   Below are the BLE read functions 
*
*/
Future<String> readBLEData(
    String service_given, String characteristic_given) async {
  var service_to_search;
  String full_char;

  if (service_given.contains("200")) {
    service_to_search = Constants.service_200;
    full_char = Constants.characteristic_format_200;
  } else {
    service_to_search = Constants.service_100;
    full_char = Constants.characteristic_format_100;
  }

  full_char = full_char.replaceAll('XXX', characteristic_given);
  debugPrint(service_to_search + " || " + full_char);
  final characteristic = QualifiedCharacteristic(
      serviceId: Uuid.parse(service_to_search),
      characteristicId: Uuid.parse(full_char),
      deviceId: Constants.bleDevice!.id);
  final response =
      await Constants.flutterReactiveBle.readCharacteristic(characteristic);

  // // this is for reading the writen value...

  debugPrint("temp val == " + response.toString());
  return response.toString();
}

readSensorsData(characteristic_given) {
  /* var readFlagStatus;

        String full_char = Constants.characteristic_format_200;
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
    });*/
}

/*
*
*   Below are the BLE notification functions 
*
*/
listenBLEData(String characteristic_given) {
  /* var service_to_search;

  String full_char;
  if (controllerServiceRead.text.contains("200")) {
    service_to_search = Constants.service_200;
    full_char = Constants.characteristic_format_200;
  } else {
    service_to_search = Constants.service_100;
    full_char = Constants.characteristic_format_100;
  }

  final characteristic = QualifiedCharacteristic(
      serviceId: serviceUuid,
      characteristicId: characteristicUuid,
      deviceId: foundDeviceId);
  flutterReactiveBle.subscribeToCharacteristic(characteristic).listen((data) {
    // code to handle incoming data
  }, onError: (dynamic error) {
    // code to handle errors
  });

  Constants.bleDevice.discoverServices().then((services) {
    services.forEach((service) async {
      var serviceDispName = service.uuid.toString();
      print("print:servicename" + serviceDispName);

      var service_to_search;

      String full_char;
      if (controllerServiceRead.text.contains("200")) {
        service_to_search = Constants.service_200;
        full_char = Constants.characteristic_format_200;
      } else {
        service_to_search = Constants.service_100;
        full_char = Constants.characteristic_format_100;
      }

      if (service.uuid.toString() == service_to_search) {
        print("found service...");
        //String full_char = Constants.characteristic_format;
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
  });*/
}

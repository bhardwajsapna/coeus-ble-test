

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class SendReceive extends StatefulWidget{
  String address='';
  SendReceive(String address){
    this.address = address;
  }


  _SendReceive createState()=>_SendReceive();
}

class _SendReceive extends State<SendReceive>{
  late BluetoothConnection connection;


  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    intialize();



  }

  Future<void> intialize() async {
    try {
      print('connected device '+widget.address);
      connection = await BluetoothConnection.toAddress(widget.address);
      print('Connected to the device');
    }
    catch (exception) {
      print(exception.toString());
      intialize();
      print('Cannot connect, exception occured');
    }
  }

  void receive(){
    connection.input!.listen((Uint8List data) {
      print('Data incoming: ${ascii.decode(data)}');
      connection.output.add(data); // Sending data

      if (ascii.decode(data).contains('!')) {
        connection.finish(); // Closing connection
        print('Disconnecting by local host');
      }
    }).onDone(() {
      print('Disconnected by remote request');
    });


  }

  void send(){
    String name = 'Ankit';
     Uint8List code =  ascii.encode(name);
    connection.output.add(code);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: Column(
            children: [
              TextButton(onPressed: (){
                send();
              },
                  child: Text(
                    'Send'
                  )),
              TextButton(onPressed: (){
                receive();
              },
                  child: Text(
                      'Receive'
                  ))
            ],
          ),
        ),
      ),
    );
  }

}
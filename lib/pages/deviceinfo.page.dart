import 'package:coeus_v1/utils/const.dart';
import 'package:flutter/material.dart';
import 'package:coeus_v1/widget/button.dart';
import 'package:coeus_v1/widget/textLogin.dart';

class DeviceInfoProfilePage extends StatefulWidget {
  @override
  _DeviceInfoProfilePageState createState() => _DeviceInfoProfilePageState();
}

class _DeviceInfoProfilePageState extends State<DeviceInfoProfilePage> {
  final ScrollController _scrollController = new ScrollController();

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
                    TextWrapper(textstr: "Firmware Version: 1.0", font: 22),
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

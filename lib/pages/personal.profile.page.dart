import 'dart:convert';
import 'dart:io';

import 'package:coeus_v1/utils/const.dart';
import 'package:coeus_v1/utils/user_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:coeus_v1/widget/button.dart';
import 'package:coeus_v1/widget/inputEmail.dart';
import 'package:coeus_v1/widget/textLogin.dart';
import 'package:coeus_v1/widget/date_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

/*
23 aug 21 - sreeni
*/
import 'package:coeus_v1/services/api.dart';

class PersonalProfilePage extends StatefulWidget {
  @override
  _PersonalProfilePageState createState() => _PersonalProfilePageState();
}

class _PersonalProfilePageState extends State<PersonalProfilePage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final ScrollController _scrollController = new ScrollController();
//06 aug 21 - ns
// email cannot be edited and password can be changed
//  final controllerEmailid = TextEditingController();
  final controllerFirstName = TextEditingController();
  final controllerSecondName = TextEditingController();
  final controllerMobileNumber = TextEditingController();
  final controllerPassword = TextEditingController();
  // added this new controller for DOB for get and set - 24 aug 21
  final controllerDob = TextEditingController();

/*
23 aug 21 - sreeni
*/
  late Future<http.Response> response;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    //06 aug 21 - ns
// email cannot be edited and password can be changed
//    final emailid = await UserSecureStorage.getEmailId() ?? "";
    final fname = await UserSecureStorage.getFirstName() ?? "";
    final sname = await UserSecureStorage.getSecondName() ?? "";
    final mobilenumber = await UserSecureStorage.getMobileNumber() ?? "";
    final password = await UserSecureStorage.getPassword() ?? "";
    // added this new controller for DOB for get and set - 24 aug 21
    final dob = await UserSecureStorage.getDOB() ?? "";

    setState(() {
      print("personal.profile.page:" + fname);
      //06 aug 21 - ns
// email cannot be edited and password can be changed
//    this.controllerEmailid.text = emailid;
      this.controllerFirstName.text = fname;
      this.controllerSecondName.text = sname;
      this.controllerMobileNumber.text = mobilenumber;
      this.controllerPassword.text = password;
      // added this new controller for DOB for get and set - 24 aug 21
      this.controllerDob.text = dob.toString();
    });
  }

  Future<http.Response> updateProfileService() async {
    var requestParams = {
      "firstName": this.controllerFirstName.text,
      "secondName": this.controllerSecondName.text,
      "mobileNo": this.controllerMobileNumber.text,
      "DOB": this.controllerDob.text,
      "password": this.controllerPassword.text
    };
    print(requestParams);
    response = updateProfileAPIService(requestParams);
    print(response);
    return response;
  }

  onUpdate() async {
    print("outside val");
    //_key.currentState!.validate()
    if (true) {
      print("inside val");

      await UserSecureStorage.setFirstName(controllerFirstName.text);
      await UserSecureStorage.setSecondName(controllerSecondName.text);
      await UserSecureStorage.setMobileNumber(controllerMobileNumber.text);
      await UserSecureStorage.setPassword(controllerPassword.text);
      await UserSecureStorage.setDOB(DateTime.tryParse(controllerDob.text));

      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Are you sure you want to update these details?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                updateProfileService();
                Navigator.pop(context, 'OK');
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                SizedBox(height: 20),
                TextWrapper(textstr: "Personal Info", font: 26),
                InputField(
                  title: "First Name",
                  font: 20,
                  isPassword: false,
                  controller: controllerFirstName,
                ),
                InputField(
                  title: "Last Name",
                  font: 20,
                  isPassword: false,
                  controller: controllerSecondName,
                ),
                InputField(
                  title: "Mobile Number",
                  font: 20,
                  isPassword: false,
                  controller: controllerMobileNumber,
                ),
                DatePickerWidget(title: "DoB", controller: controllerDob),

                /*
                InputField(
                  title: "DOB",
                  font: 20,
                  isPassword: false,
                ),*/
                /*
                as email - id is being used as the primary key 
                user can change there password and not the emailid
                */
                /*
                InputField(
                  title: "Email-id",
                  font: 20,
                  isPassword: false,
                  isEditable: false,
                  controller: controllerEmailid,
                ),*/
                InputField(
                  title: "Password",
                  font: 20,
                  isPassword: false,
                  isEditable: false,
                  controller: controllerPassword,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Button(
                      onTapFunction: () => Navigator.pop(context),
                      nextNavigation: null,
                      title: "Cancel",
                      width: MediaQuery.of(context).size.width / 3),
                  Button(
                      onTapFunction: onUpdate,
                      nextNavigation: null,
                      title: "Update",
                      width: MediaQuery.of(context).size.width / 3),
                ]),
              ]),
        ),
      ]),
    );
  }
}

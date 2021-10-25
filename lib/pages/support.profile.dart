import 'package:coeus_v1/services/api.dart';
import 'package:coeus_v1/utils/const.dart';
import 'package:coeus_v1/utils/support_details_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:coeus_v1/widget/button.dart';
import 'package:coeus_v1/widget/inputEmail.dart';
import 'package:coeus_v1/widget/textLogin.dart';

import 'package:http/http.dart' as http;
// 25 oct 21 -sreeni - to provide msg to user.
import 'package:fluttertoast/fluttertoast.dart';

class SupportProfilePage extends StatefulWidget {
  @override
  _SupportProfilePageState createState() => _SupportProfilePageState();
}

class _SupportProfilePageState extends State<SupportProfilePage> {
  final controllerEmergencyEmailid = TextEditingController();
  final controllerEmergencyFirstName = TextEditingController();
  final controllerEmergencySecondName = TextEditingController();
  final controllerEmergencyMobileNumber = TextEditingController();
  final controllerCaretakerEmailid = TextEditingController();
  final controllerCaretakerFirstName = TextEditingController();
  final controllerCaretakerSecondName = TextEditingController();
  final controllerCaretakerMobileNumber = TextEditingController();

  final ScrollController _scrollController = new ScrollController();

/*
23 aug 21 - sreeni
*/
  late Future<http.Response> response;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<http.Response> updateCaregiverDetailsService() async {
    var requestParams = {
      "firstName": this.controllerCaretakerFirstName.text,
      "secondName": this.controllerCaretakerSecondName.text,
      "mobileNo": this.controllerCaretakerMobileNumber.text,
      "emailId": this.controllerCaretakerEmailid.text
    };
    print(requestParams);
    response = updateCaregiverDetailsAPIService(requestParams);
    print(response);

    return response;
  }

  Future<http.Response> updateEmergencyContactService() async {
    var requestParams = {
      "firstName": this.controllerEmergencyFirstName.text,
      "secondName": this.controllerEmergencySecondName.text,
      "mobileNo": this.controllerEmergencyMobileNumber.text,
      "emailId": this.controllerEmergencyEmailid.text
    };
    print(requestParams);
    response = updateEmergencyContactAPIService(requestParams);
    print(response);

    return response;
  }

  Future init() async {
    final emergencyemailid =
        await SupportDetailsSecureStorage.getEmergencyEmailId() ?? "";
    final emergencyfname =
        await SupportDetailsSecureStorage.getEmergencyFirstName() ?? "";
    final emergencysname =
        await SupportDetailsSecureStorage.getEmergencySecondName() ?? "";
    final emergencymobilenumber =
        await SupportDetailsSecureStorage.getEmergencyMobileNumber() ?? "";
    final caretakeremailid =
        await SupportDetailsSecureStorage.getCaretakerEmailId() ?? "";
    final caretakerfname =
        await SupportDetailsSecureStorage.getCaretakerFirstName() ?? "";
    final caretakersname =
        await SupportDetailsSecureStorage.getCaretakerSecondName() ?? "";
    final caretakermobilenumber =
        await SupportDetailsSecureStorage.getCaretakerMobileNumber() ?? "";
    setState(() {
      print("personal.profile.page:" + emergencyfname);
      this.controllerEmergencyEmailid.text = emergencyemailid;
      this.controllerEmergencyFirstName.text = emergencyfname;
      this.controllerEmergencySecondName.text = emergencysname;
      this.controllerEmergencyMobileNumber.text = emergencymobilenumber;
      this.controllerCaretakerEmailid.text = caretakeremailid;
      this.controllerCaretakerFirstName.text = caretakerfname;
      this.controllerCaretakerSecondName.text = caretakersname;
      this.controllerCaretakerMobileNumber.text = caretakermobilenumber;
    });
  }

  onUpdate() async {
/*
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('AlertDialog Title'),
        content: const Text('AlertDialog description'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'OK');
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
*/
/*
23 aug 21 - sreeni
now update the server data using service functions
*/
    bool isValid = true;
    updateEmergencyContactService().then((response) {
      if (response.statusCode != 200) {
        isValid = false;
      }
    });
    updateCaregiverDetailsService().then((response) {
      if (response.statusCode != 200) {
        isValid = false;
      }
    });

    if (isValid) {
      SupportDetailsSecureStorage.setEmergencyEmailId(
          controllerEmergencyEmailid.text);
      SupportDetailsSecureStorage.setEmergencyFirstName(
          controllerEmergencyFirstName.text);
      SupportDetailsSecureStorage.setEmergencySecondName(
          controllerEmergencySecondName.text);
      SupportDetailsSecureStorage.setEmergencyMobileNumber(
          controllerEmergencyMobileNumber.text);

      SupportDetailsSecureStorage.setCaretakerEmailId(
          controllerCaretakerEmailid.text);
      SupportDetailsSecureStorage.setCaretakerFirstName(
          controllerCaretakerFirstName.text);
      SupportDetailsSecureStorage.setCaretakerSecondName(
          controllerCaretakerSecondName.text);
      SupportDetailsSecureStorage.setCaretakerMobileNumber(
          controllerCaretakerMobileNumber.text);

      Fluttertoast.showToast(
          msg: "Details updated",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      Fluttertoast.showToast(
          msg: "Some error occured. Please try later.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    // 25 Oct 21 - sreeni - added to get back to home screen
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        SizedBox(
          height: 20,
        ),
        Container(
          height: MediaQuery.of(context).size.height - 50,
          // decoration: BoxDecoration(
          //   gradient: LinearGradient(
          //       begin: Alignment.topRight,
          //       end: Alignment.bottomLeft,
          //       colors: [Constants.white, Constants.lightBlue]),
          // ),
          child: ListView(children: [
            Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                    children: [
                      TextWrapper(textstr: "Emergency Contact", font: 36),
                      InputField(
                        title: "First Name",
                        font: 18,
                        isPassword: false,
                        controller: controllerEmergencyFirstName,
                      ),
                      InputField(
                        title: "Last Name",
                        font: 18,
                        isPassword: false,
                        controller: controllerEmergencySecondName,
                      ),
                      InputField(
                        title: "Mobile Number",
                        font: 18,
                        isPassword: false,
                        controller: controllerEmergencyMobileNumber,
                      ),
                      InputField(
                        title: "Email-id",
                        font: 18,
                        isPassword: false,
                        controller: controllerEmergencyEmailid,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      TextWrapper(textstr: "Caregiver Contact", font: 36),
                      InputField(
                        title: "First Name",
                        font: 18,
                        isPassword: false,
                        controller: controllerCaretakerFirstName,
                      ),
                      InputField(
                        title: "Last Name",
                        font: 18,
                        isPassword: false,
                        controller: controllerCaretakerSecondName,
                      ),
                      InputField(
                        title: "Mobile Number",
                        font: 18,
                        isPassword: false,
                        controller: controllerCaretakerMobileNumber,
                      ),
                      InputField(
                        title: "Email-id",
                        font: 18,
                        isPassword: false,
                        controller: controllerCaretakerEmailid,
                      ),
                    ],
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Button(
                      onTapFunction: () => {Navigator.pop(context)},
                      nextNavigation: null,
                      title: "Cancel",
                      width: MediaQuery.of(context).size.width / 3,
                      baseColor: Constants.musturd,
                    ),
                    Button(
                      onTapFunction: onUpdate,
                      nextNavigation: null,
                      title: "Update",
                      width: MediaQuery.of(context).size.width / 3,
                      baseColor: Constants.musturd,
                    ),
                  ]),
                ]),
          ]),
        ),
      ]),
    );
  }
}

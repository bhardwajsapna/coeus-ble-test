import 'package:coeus_v1/utils/const.dart';
import 'package:coeus_v1/utils/support_details_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:coeus_v1/widget/button.dart';
import 'package:coeus_v1/widget/inputEmail.dart';
import 'package:coeus_v1/widget/textLogin.dart';

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

  @override
  void initState() {
    super.initState();
    init();
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
    await SupportDetailsSecureStorage.setEmergencyEmailId(
        controllerEmergencyEmailid.text);
    await SupportDetailsSecureStorage.setEmergencyFirstName(
        controllerEmergencyFirstName.text);
    await SupportDetailsSecureStorage.setEmergencySecondName(
        controllerEmergencySecondName.text);
    await SupportDetailsSecureStorage.setEmergencyMobileNumber(
        controllerEmergencyMobileNumber.text);

    await SupportDetailsSecureStorage.setCaretakerEmailId(
        controllerCaretakerEmailid.text);
    await SupportDetailsSecureStorage.setCaretakerFirstName(
        controllerCaretakerFirstName.text);
    await SupportDetailsSecureStorage.setCaretakerSecondName(
        controllerCaretakerSecondName.text);
    await SupportDetailsSecureStorage.setCaretakerMobileNumber(
        controllerCaretakerMobileNumber.text);

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
                        width: MediaQuery.of(context).size.width / 3),
                    Button(
                        onTapFunction: onUpdate,
                        nextNavigation: null,
                        title: "Update",
                        width: MediaQuery.of(context).size.width / 3),
                  ]),
                ]),
          ]),
        ),
      ]),
    );
  }
}

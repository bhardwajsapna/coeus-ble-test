import 'package:coeus_v1/utils/const.dart';
import 'package:coeus_v1/utils/user_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:coeus_v1/widget/button.dart';
import 'package:coeus_v1/widget/inputEmail.dart';
import 'package:coeus_v1/widget/textLogin.dart';

class PersonalProfilePage extends StatefulWidget {
  @override
  _PersonalProfilePageState createState() => _PersonalProfilePageState();
}

class _PersonalProfilePageState extends State<PersonalProfilePage> {
  final ScrollController _scrollController = new ScrollController();

  final controllerEmailid = TextEditingController();
  final controllerFirstName = TextEditingController();
  final controllerSecondName = TextEditingController();
  final controllerMobileNumber = TextEditingController();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    final emailid = await UserSecureStorage.getEmailId() ?? "";
    final fname = await UserSecureStorage.getFirstName() ?? "";
    final sname = await UserSecureStorage.getSecondName() ?? "";
    final mobilenumber = await UserSecureStorage.getMobileNumber() ?? "";

    setState(() {
      print("personal.profile.page:" + fname);
      this.controllerEmailid.text = emailid;
      this.controllerFirstName.text = fname;
      this.controllerSecondName.text = sname;
      this.controllerMobileNumber.text = mobilenumber;
    });
  }

  onUpdate() async {
    await UserSecureStorage.setFirstName(controllerFirstName.text);
    await UserSecureStorage.setSecondName(controllerSecondName.text);
    await UserSecureStorage.setMobileNumber(controllerMobileNumber.text);
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
                InputField(
                  title: "DOB",
                  font: 20,
                  isPassword: false,
                ),
                InputField(
                  title: "Email-id",
                  font: 20,
                  isPassword: false,
                  isEditable: false,
                  controller: controllerEmailid,
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

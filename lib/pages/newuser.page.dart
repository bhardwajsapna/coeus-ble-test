import 'package:coeus_v1/utils/user_secure_storage.dart';
import 'package:coeus_v1/widget/button.dart';
import 'package:coeus_v1/widget/date_picker.dart';
import 'package:coeus_v1/widget/gender.dart';
import 'package:coeus_v1/widget/inputEmail.dart';
import 'package:coeus_v1/widget/textLogin.dart';
import 'package:flutter/material.dart';

class NewUser extends StatefulWidget {
  @override
  _NewUserState createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  final controllerUserName = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerRePassword = TextEditingController();
  final controllerFirstName = TextEditingController();
  final controllerSecondName = TextEditingController();
  final controllerMobileNumber = TextEditingController();
  final controllerGender = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void register_user() async {
    print(controllerUserName.text);
    print(controllerPassword.text);
    await UserSecureStorage.setEmailId(controllerUserName.text);
    await UserSecureStorage.setPassword(controllerPassword.text);
    await UserSecureStorage.setFirstName(controllerFirstName.text);
    await UserSecureStorage.setSecondName(controllerSecondName.text);
    await UserSecureStorage.setMobileNumber(controllerMobileNumber.text);
    await UserSecureStorage.setGender(controllerGender.text);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        // decoration: BoxDecoration(
        //   gradient: LinearGradient(
        //       begin: Alignment.topRight,
        //       end: Alignment.bottomLeft,
        //       colors: [Constants.white, Constants.lightBlue]),
        // ),
        child: Container(
          child: ListView(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 30),
                  TextWrapper(textstr: "Coeus", font: 36),
                  InputField(
                    title: "First Name",
                    font: 22,
                    isPassword: false,
                    controller: controllerFirstName,
                  ),
                  InputField(
                    title: "Second Name",
                    font: 20,
                    isPassword: false,
                    controller: controllerSecondName,
                  ),
                  InputField(
                    title: "Email-id",
                    font: 20,
                    isPassword: false,
                    controller: controllerUserName,
                  ),
                  InputField(
                    title: "Mobile No.",
                    font: 22,
                    isPassword: false,
                    controller: controllerMobileNumber,
                  ),
                  // InputField(
                  //   title: "DOB",
                  //   font: 22,
                  //   isPassword: false,
                  // ),
                  DatePickerWidget(title: "DoB"),
                  // InputField(
                  //   title: "Gender",
                  //   font: 22,
                  //   isPassword: false,
                  //   controller: controllerGender,
                  // ),
                  GenderSelector(),
                  InputField(
                    title: "Password",
                    font: 22,
                    isPassword: true,
                    controller: controllerPassword,
                  ),
                  InputField(
                    title: "Re-enter Password",
                    font: 22,
                    isPassword: true,
                    controller: controllerRePassword,
                  ),
                  Button(
                    onTapFunction: register_user,
                    title: "Register",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

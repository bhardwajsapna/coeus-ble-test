import 'package:coeus_v1/utils/user_secure_storage.dart';
import 'package:coeus_v1/widget/button.dart';
import 'package:coeus_v1/widget/date_picker.dart';
import 'package:coeus_v1/widget/gender.dart';
import 'package:coeus_v1/widget/inputEmail.dart';
import 'package:coeus_v1/widget/textLogin.dart';
import 'package:email_validator/email_validator.dart';
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
  static const validSymbols =  "!\"#\$%&'()*+,-./:;<=>?@[\\]^_`{|}~";
  bool isPassLong = false;
  bool isPassNumber = false;
  bool isPassSymbol = false;

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
  bool passIsValid(String value){
    String  pattern = '^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[$validSymbols]).{5,}\$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }
  bool passHaveNumber(String value){
    String  pattern = r'^(?=.*?[0-9]).{1,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  bool passHaveSymbol(String value){
    String  pattern = '^(?=.*?[$validSymbols]).{1,}\$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
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
                    validator: (email) => EmailValidator.validate(email!)? null: "Invalid email address",
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
                    onChanged: (val){
                      setState(() {
                        controllerPassword.text.length > 5 ?
                        isPassLong = true :
                        isPassLong = false;
                        passHaveNumber(controllerPassword.text) ?
                        isPassNumber = true :
                        isPassNumber = false;
                        passHaveSymbol(controllerPassword.text) ?
                        isPassSymbol = true :
                        isPassSymbol = false;
                      });
                    },

                    validator: (String? value){
                      if(value!.isEmpty) {
                        return 'Please enter password';
                      }
                      if(!passIsValid(controllerPassword.text)) {
                        return 'Password must be at least 5 characters long and consist of letters, numbers and symbols';
                      }
                      return null;
                    },
                  ),

                  InputField(
                    title: "Re-enter Password",
                    font: 22,
                    isPassword: true,
                    controller: controllerRePassword,
                    onChanged: (val){
                      setState(() {
                        controllerPassword.text.length > 5 ?
                        isPassLong = true :
                        isPassLong = false;
                        passHaveNumber(controllerPassword.text) ?
                        isPassNumber = true :
                        isPassNumber = false;
                        passHaveSymbol(controllerPassword.text) ?
                        isPassSymbol = true :
                        isPassSymbol = false;
                      });
                    },

                    validator: (String? value){
                      if(value!.isEmpty) {
                        return 'Please enter password';
                      }
                      if(!passIsValid(controllerPassword.text)) {
                        return 'Password must be at least 5 characters long and consist of letters, numbers and symbols';
                      }
                      return null;
                    },
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

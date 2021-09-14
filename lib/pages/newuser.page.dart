import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:coeus_v1/services/api.dart';
import 'package:coeus_v1/utils/user_secure_storage.dart';
import 'package:coeus_v1/widget/button.dart';
import 'package:coeus_v1/widget/date_picker.dart';
import 'package:coeus_v1/widget/gender.dart';
import 'package:coeus_v1/widget/inputEmail.dart';

import 'package:coeus_v1/widget/textLogin.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class NewUser extends StatefulWidget {
  @override
  _NewUserState createState() => _NewUserState();
}

class _NewUserState extends State<NewUser> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final controllerUserName = TextEditingController();
  final controllerPassword = TextEditingController();
  final controllerRePassword = TextEditingController();
  final controllerFirstName = TextEditingController();
  final controllerSecondName = TextEditingController();
  final controllerMobileNumber = TextEditingController();
  final controllerGender = TextEditingController();

  // adding the controller of dob to save in the db
  final controllerDob = TextEditingController();

/*
28 aug 21 - sreeni
*/
  late Future<http.Response> response;

  static const validSymbols = "!\"#\$%&'()*+,-./:;<=>?@[\\]^_`{|}~";
  bool isPassLong = false;
  bool isPassNumber = false;
  bool isPassSymbol = false;
  bool isPassSame = false;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<http.Response> createUserService() async {
    var requestParams = {
      "firstName": this.controllerFirstName.text,
      "secondName": this.controllerSecondName.text,
      "mobileNo": this.controllerMobileNumber.text,
      "DOB": this.controllerDob.text,
      "password": this.controllerPassword.text,
      "gender": this.controllerGender.text,
      "emailId": this.controllerUserName.text,
      "activeUser": true,
      "validEmail": true
    };
    print(requestParams);
    response = createUserAPIService(requestParams);
    print(response);
    return response;
  }

  void register_user() async {
    if (_formKey.currentState!.validate()) {
      print(controllerUserName.text);
      print(controllerPassword.text);
      await UserSecureStorage.setEmailId(controllerUserName.text);
      await UserSecureStorage.setPassword(controllerPassword.text);
      await UserSecureStorage.setFirstName(controllerFirstName.text);
      await UserSecureStorage.setSecondName(controllerSecondName.text);
      await UserSecureStorage.setMobileNumber(controllerMobileNumber.text);
      await UserSecureStorage.setGender(controllerGender.text);

      //29 aug 21 - sreeni added the dob
      await UserSecureStorage.setDOB(DateTime.parse(controllerDob.text));

      Navigator.pop(context);
/*
28 aug 21 - sreeni - api for new user
*/
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Confirmation'),
          content: const Text(
              'Are you sure you want to create User with this information?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                createUserService();
                Navigator.pop(context, 'OK');
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }


    Navigator.pop(context);
  }

  bool passIsValid(String value) {
    String pattern =
        '^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[$validSymbols]).{5,}\$';

    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  bool repassIsValid(String value) {
    String pattern =
        '^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[$validSymbols]).{5,}\$';
    RegExp regExp = new RegExp(pattern);

    return (regExp.hasMatch(value) && isPassSame);
  }

  bool passHaveNumber(String value) {
    String pattern = r'^(?=.*?[0-9]).{1,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
  }

  bool passHaveSymbol(String value) {
    String pattern = '^(?=.*?[$validSymbols]).{1,}\$';
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
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(

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
                  validator: (email) {
                    return EmailValidator.validate(email!)
                        ? null
                        : "Invalid email address";
                  },
                  controller: controllerUserName,
                  keyboardType: TextInputType.emailAddress,
                ),
                InputField(
                  title: "Mobile No.",
                  font: 22,
                  isPassword: false,
                  controller: controllerMobileNumber,
                  keyboardType: TextInputType.phone,
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
                  onChanged: (val) {
                    setState(() {
                      controllerPassword.text.length > 5
                          ? isPassLong = true
                          : isPassLong = false;
                      passHaveNumber(controllerPassword.text)
                          ? isPassNumber = true
                          : isPassNumber = false;
                      passHaveSymbol(controllerPassword.text)
                          ? isPassSymbol = true
                          : isPassSymbol = false;
                    });
                  },
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please enter password';
                    }
                    if (!passIsValid(controllerPassword.text)) {
                      return 'Password must be at least 5 characters long and consist of letters, numbers and symbols';
                    }
                  },
                ),


                InputField(
                  title: "Re-enter Password",
                  font: 22,
                  isPassword: true,
                  controller: controllerRePassword,
                  onChanged: (val) {
                    setState(() {
                      controllerPassword.text.length > 5
                          ? isPassLong = true
                          : isPassLong = false;
                      passHaveNumber(controllerPassword.text)
                          ? isPassNumber = true
                          : isPassNumber = false;
                      passHaveSymbol(controllerPassword.text)
                          ? isPassSymbol = true
                          : isPassSymbol = false;
                      controllerPassword.text == controllerRePassword.text
                          ? isPassSame = true
                          : isPassSame = false;
                    });
                  },
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'Please enter password';
                    }
                    if (!repassIsValid(controllerPassword.text)) {
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
          ),
        ),
      ),
    );
  }
}

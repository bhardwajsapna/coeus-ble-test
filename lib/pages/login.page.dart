import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:coeus_v1/widget/button.dart';
import 'package:coeus_v1/widget/first.dart';
import 'package:coeus_v1/widget/inputEmail.dart';
import 'package:coeus_v1/widget/textLogin.dart';

import 'dashboard.page.dart';
import 'package:coeus_v1/utils/const.dart';
import 'package:coeus_v1/utils/user_secure_storage.dart';

class LoginPage extends StatefulWidget {
  String action = "";
  LoginPage({required this.action});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final controllerUserName = TextEditingController();
  final controllerPassword = TextEditingController();
  String? uname;
  String? password;
  static const validSymbols = "!\"#\$%&'()*+,-./:;<=>?@[\\]^_`{|}~";
  bool isPassLong = false;
  bool isPassNumber = false;
  bool isPassSymbol = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    if (widget.action == 'logout') {
      await UserSecureStorage.logOut();
    } else {
      String? password = await UserSecureStorage.getPassword() ?? 'admin';
      String? uname = await UserSecureStorage.getEmailId() ?? 'admin';
      setState(() {
        this.uname = uname;
        this.password = password;
      });
    }
  }

  bool passIsValid(String value) {
    String pattern =
        '^(?=.*?[a-zA-Z])(?=.*?[0-9])(?=.*?[$validSymbols]).{5,}\$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(value);
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

  void onLoginSubmit() async {
    if (_formKey.currentState!.validate()) {
      bool isvalid = false;
      if (this.uname == controllerUserName.text) {
        if (this.password == controllerPassword.text) {
          isvalid = true;
          print("success");
        } else {
          isvalid = false;
        }
      } else {
        isvalid = false;
      }
      if (isvalid) {
        UserSecureStorage.getUserID()
            .then((value) => Constants.userId = value!);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Dashboard()));
      } else {
        controllerUserName.text = "";
        controllerPassword.text = "";
      }
    }
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
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //SizedBox(height: 10),
              Image(
                  width: 250,
                  height: 250,
                  image: AssetImage('assets/icons/coeuslogo_elipse.png')),
              //      TextWrapper(textstr: "Coeus", font: 34),
              InputField(
                title: "Email-id",
                font: 24,
                isPassword: false,
                controller: controllerUserName,
                validator: (email) {
                  return EmailValidator.validate(email!)
                      ? null
                      : "Invalid email address";
                },
              ),
              InputField(
                title: "Password",
                font: 24,
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
/*
23 oct 21 - sreeni
i dont think this check is required here.
*/
                  /*       if (!passIsValid(controllerPassword.text)) {
                    return 'Password must be at least 5 characters long and consist of letters, numbers and symbols';
                  }
                  */
                },
              ),
              Button(
                title: "Login",
                onTapFunction: onLoginSubmit,
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

import 'package:coeus_v1/pages/scheduling.profile.dart';
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

  void onLoginSubmit() async {
    bool isvalid = false;
    if (_key.currentState!.validate()) {
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
      resizeToAvoidBottomInset: false,
        body: Form(
      key: _key,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 100),
          TextWrapper(textstr: "Coeus", font: 34),
          InputField(
            title: "Email-id",
            font: 24,
            isPassword: false,
            controller: controllerUserName,
          ),
          InputField(
            title: "Password",
            font: 24,
            isPassword: true,
            controller: controllerPassword,
          ),
          Button(
            title: "Login",
            onTapFunction: onLoginSubmit,
          ),
        ],
      ),
    ));
  }
}

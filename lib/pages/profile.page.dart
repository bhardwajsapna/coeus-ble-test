import 'package:coeus_v1/appState/loginState.dart';
import 'package:coeus_v1/pages/advancedSettings.profile.dart';
import 'package:coeus_v1/pages/app.page.dart';
import 'package:coeus_v1/pages/deviceinfo.page.dart';
import 'package:coeus_v1/pages/login.page.dart';
import 'package:coeus_v1/pages/personal.profile.page.dart';
import 'package:coeus_v1/pages/scheduling.profile.dart';
import 'package:coeus_v1/pages/support.profile.dart';
import 'package:coeus_v1/widget/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        // decoration: BoxDecoration(
        //       gradient: LinearGradient(
        //           begin: Alignment.topRight,
        //           end: Alignment.bottomLeft,
        //           colors: [Constants.white, Constants.lightBlue]),
        //     ),
        child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Button(
              title: "Personal Info",
              nextNavigation: PersonalProfilePage(),
              width: MediaQuery.of(context).size.width),
          Button(
              title: "Caregiver Details",
              nextNavigation: SupportProfilePage(),
              width: MediaQuery.of(context).size.width),
          /*
        29 sep 21
        sapna sreeni - this is no more required as the schedule is provided in advance setting as discussed with sriharsha
          Button(
              title: "Monitoring Schedule",
              nextNavigation: SchedulingProfilePage(),
              width: MediaQuery.of(context).size.width), 
              */
          Button(
              title: "Advanced Settings",
              nextNavigation: AdvancedSettingsProfilePage(),
              width: MediaQuery.of(context).size.width),
          Button(
              title: "Device Info",
              nextNavigation: DeviceInfoProfilePage(),
              width: MediaQuery.of(context).size.width),
          Button(
              title: "Log Out",
              /*
              23 oct 21 - sreeni
              this function on openapp is opening the app once again but not logging out
              */
              nextNavigation: OpenApp(),
              width: MediaQuery.of(context).size.width),
        ],
      ),
    ));
  }
}

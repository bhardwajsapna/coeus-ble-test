import 'package:coeus_v1/pages/advancedSettings.profile.dart';
import 'package:coeus_v1/pages/deviceinfo.page.dart';
import 'package:coeus_v1/pages/personal.profile.page.dart';
import 'package:coeus_v1/pages/scheduling.profile.dart';
import 'package:coeus_v1/pages/support.profile.dart';
import 'package:coeus_v1/utils/const.dart';
import 'package:coeus_v1/widget/button.dart';
import 'package:flutter/cupertino.dart';

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
        Button(
            title: "Monitoring Schedule",
            nextNavigation: SchedulingProfilePage(),
            width: MediaQuery.of(context).size.width),
        Button(
            title: "Advanced Settings",
            nextNavigation: AdvancedSettingsProfilePage(),
            width: MediaQuery.of(context).size.width),
        Button(
            title: "Device Info",
            nextNavigation: DeviceInfoProfilePage(),
            width: MediaQuery.of(context).size.width),
      ],
    ));
  }
}

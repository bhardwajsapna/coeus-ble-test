import 'package:coeus_v1/components/summary_card.dart';
import 'package:coeus_v1/pages/connectdevice.page.dart';
import 'package:coeus_v1/pages/home.page.dart';
import 'package:coeus_v1/pages/profile.page.dart';
import 'package:coeus_v1/utils/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

int _index = 0;

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  @override
  Widget build(BuildContext context) {
    Widget child = Container();

    switch (_index) {
      case 2:
        child = ProfilePage();
        break;

      case 0:
        child = HomePage();
        break;

      case 1:
        child = DiscoveryPage();
    }

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Coeus"),
      ),
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (int index) => setState(() => _index = index),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.lightBlue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.watch),
            label: 'Connect Device',
            backgroundColor: Colors.lightBlue,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
            backgroundColor: Colors.lightBlue,
          ),
        ],
        selectedItemColor: Colors.black,
      ),
    );
  }
}

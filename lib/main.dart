import 'package:coeus_v1/pages/app.page.dart';
import 'package:flutter/material.dart';
import './pages/login.page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OpenApp(),
      debugShowCheckedModeBanner: false,
    );
  }
}


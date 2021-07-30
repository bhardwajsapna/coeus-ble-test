import 'package:coeus_v1/appState/loginState.dart';
import 'package:coeus_v1/pages/app.page.dart';
import 'package:coeus_v1/utils/storageUtils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './pages/login.page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginStateProvider>(
            create: (context) => LoginStateProvider()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: OpenApp(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

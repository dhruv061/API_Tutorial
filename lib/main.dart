import 'package:api/Pages/HomePage.dart';
import 'package:api/Pages/SecoundAPI_CustomModel.dart';
import 'package:flutter/material.dart';

import 'Pages/Third_ComplexAPI.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // home: HomePage(),
      // home: SecoundAPI_CustomModel(),
      home: ComplexAPICall(),
    );
  }
}

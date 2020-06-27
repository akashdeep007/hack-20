import 'package:flutter/material.dart';
import 'package:the_robin_app/pages/Wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'The Robin Hood Army',
      theme: ThemeData(
        buttonTheme: ButtonThemeData(
          height: 45,
          minWidth: 110,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(29)
          )
        ),
        textTheme: TextTheme(
          headline1: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
        ),
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Wrapper(),
    );
  }
}
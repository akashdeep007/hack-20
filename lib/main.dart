import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_robin_app/blocs/AuthService.dart';
import 'package:the_robin_app/pages/Wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<FirebaseUser>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'The Robin Hood Army',
        theme: ThemeData(
          buttonTheme: ButtonThemeData(
            textTheme: ButtonTextTheme.primary,
            height: 43,
            minWidth: 130,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(29),
            )
          ),
          textTheme: TextTheme(
            headline1: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, letterSpacing: 3),
            button: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
          primarySwatch: Colors.green,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: Wrapper(),
      ),
    );
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_robin_app/blocs/DatabaseService.dart';
import 'package:the_robin_app/models/User.dart';
import 'package:the_robin_app/pages/AuthForm.dart';
import 'package:the_robin_app/pages/Main/Home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
    return user == null ? AuthForm(false) : StreamProvider<User>.value(value: DatabaseService(uid: user.uid).user,child: Home());
  }
}

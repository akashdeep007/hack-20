import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_robin_app/pages/AuthForm.dart';
import 'package:the_robin_app/pages/Home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<FirebaseUser>(context);
    print(auth);
    return auth == null ? AuthForm(false) : Home();
  }
}

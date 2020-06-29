import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_robin_app/blocs/DatabaseService.dart';
import 'package:the_robin_app/blocs/EventService.dart';
import 'package:the_robin_app/models/Event.dart';
import 'package:the_robin_app/models/User.dart';
import 'package:the_robin_app/pages/AuthForm.dart';
import 'package:the_robin_app/pages/Main/Main.dart';
import 'package:the_robin_app/widgets/Forms/EventRegister.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FirebaseUser>(context);
//    return Scaffold(body: EventRegister(user: User(),));
    return user == null ?  AuthForm(false) :
    MultiProvider(
         providers: [
           StreamProvider<User>.value(value: DatabaseService(uid: user.uid).user),
           StreamProvider<List<Event>>.value(value: EventService(uid: user.uid).events, initialData: [],),
         ],
        child: Main());
  }
}

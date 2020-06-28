import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_robin_app/blocs/AuthService.dart';
import 'package:the_robin_app/models/User.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final user = Provider.of<User>(context);
    return user != null ? SizedBox.expand(
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          CustomPaint(painter: BackDropPaint(),child: Container(),),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(user.name),
              RaisedButton(onPressed: _auth.signOut, child: Text("Log Out"),)
            ],
          ),

        ],
      ),
    ) : Center(child: CircularProgressIndicator(),);
  }
}


class BackDropPaint extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width/2, 0);
    canvas.drawCircle(center, 200, Paint()..color = Colors.greenAccent);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
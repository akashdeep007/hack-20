import 'package:flutter/material.dart';
import 'package:the_robin_app/widgets/CustomCircles.dart';
import 'package:the_robin_app/widgets/Login.dart';
import 'package:the_robin_app/widgets/Signup.dart';

class AuthForm extends StatefulWidget {
  final bool isSignup;
  AuthForm(this.isSignup);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  bool _isSignup;

  @override
  void initState() {
    super.initState();
    _isSignup = widget.isSignup;
  }

  void _changeForm(){
    setState(() {
      _isSignup = !_isSignup;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
          child : Stack(
            children: <Widget>[
              CustomPaint(
                painter: topDesign(),
                child: Container(
                  height: 100,
                ),
              ),
              AnimatedSwitcher(
                duration: Duration(milliseconds: 200),
                transitionBuilder: (child, animation) => ScaleTransition(scale: animation, alignment: FractionalOffset.center, child: child,),
                child: _isSignup ? Signup(changeForm: _changeForm) : Login(changeForm: _changeForm,),
              ),
            ],
          )
      ),
    );;
  }
}

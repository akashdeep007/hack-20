import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_robin_app/blocs/AuthService.dart';
import 'package:the_robin_app/widgets/CustomCircles.dart';
import 'package:the_robin_app/widgets/Signup.dart';

class Login extends StatefulWidget {
  Function changeForm;
  Login({this.changeForm});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _email = "";
  String _password = "";
  final _formKey = GlobalKey<FormState>();

  _buildFormField(String title, Function inputHandler){
    return Container(
      height: 45,
      margin: EdgeInsets.all(10),
      child: Material(
        borderRadius: BorderRadius.circular(29),
        shadowColor: Colors.grey,
        elevation: 6,
        child: TextFormField(
          obscureText: title.split(" ").last == "Password",
          validator: (value){
            if(value.length == 0) return 'Enter your $title';
          },
          style: TextStyle(fontSize: 14),
          onChanged: (value) => inputHandler(title, value),
          decoration: InputDecoration(
            labelText: title,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            isDense: true,
            errorBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0, color: Colors.white),
                gapPadding: 12.0,
                borderRadius: BorderRadius.circular(29)
            ),
            errorStyle: TextStyle(height: -1, inherit: debugInstrumentationEnabled),
            focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 0, color: Colors.white),
                borderRadius: BorderRadius.circular(29)
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(29)
            ),
            prefixIcon: title == "Email" ? Icon(Icons.email) : Icon(Icons.lock),
          ),
        ),
      ),
    );
  }

  void inputHandler(String inputField, String value){
    switch(inputField){
      case "Email":
        setState(() => _email = value);
        break;
      case "Password":
        setState(() => _password = value);
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        SizedBox(height: 1,),
        Container(
          margin: EdgeInsets.only(left: 10),
          width: width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Welcome", style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),),
              Text("Sign in to your Account"),
            ],
          ),
        ),
        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _buildFormField("Email", inputHandler),
              _buildFormField("Password", inputHandler)
            ],
          ),
        ),
        Column(
          children: <Widget>[
            RaisedButton(onPressed: () async {
              print(_email + " " + _password);
              if(_formKey.currentState.validate()){
                await _auth.signInWithEmailAndPassword(_email.trim(), _password.trim());
              }
            }, child: Text("Sign In"), elevation: 3,),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Do not have an Account ?", style: TextStyle(fontSize: 14),),
                SizedBox(width: 5,),
                InkWell(
                    onTap: () => widget.changeForm(),
                    child: Text("Register", style: TextStyle(fontSize: 14, color: Colors.green), ))
              ],),
          ],
        ),

      ],
    );
  }
}
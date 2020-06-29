import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_robin_app/blocs/AuthService.dart';
import 'package:validators/validators.dart' as validators;
import 'package:the_robin_app/widgets/Forms/InputField.dart';

class Login extends StatefulWidget {
  final Function changeForm;
  Login({this.changeForm});
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _email = "";
  String _password = "";
  bool _emailError = false;
  bool _passwordError = false;

  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  void inputHandler(String inputField, String value) {
    switch (inputField) {
      case "Email":
        setState(() {
          _email = value;
          _emailError = false;
        });
        break;
      case "Password":
        setState((){
          _password = value;
          _passwordError = false;
        });
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    final width = MediaQuery.of(context).size.width;
//    final height = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                height: 1,
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Welcome",
                      style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                    ),
                    Text("Sign in to your Account"),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical : 20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
//              _buildFormField("Email", inputHandler),
//              _buildFormField("Password", inputHandler)
                      CustomInputField(title: "Email", icon: Icons.email, error: _emailError, inputHandler: inputHandler,),
                      CustomInputField(title: "Password", icon: Icons.lock, error: _passwordError, inputHandler: inputHandler, isObsecure: true,),

                    ],
                  ),
                ),
              ),
              Column(
                children: <Widget>[
                  RaisedButton(
                    onPressed: () async {
                      if(!validators.isEmail(_email.trim())) setState(() => _emailError = true);
                      if(_password.trim().length < 8) setState(() => _passwordError = true);
                      if(!_emailError && !_passwordError) {
                        setState(() => isLoading = true);
                        await _auth.signInWithEmailAndPassword(_email, _password);
                        setState(() => isLoading = false);
                      }
                    },
                    child: Text("Sign In"),
                    elevation: 3,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "Do not have an Account ?",
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                          onTap: () => widget.changeForm(),
                          child: Text(
                            "Register",
                            style: TextStyle(fontSize: 14, color: Colors.green),
                          ))
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        isLoading ? SizedBox.expand(child: Container(color: Colors.black26,child: Center(child: CircularProgressIndicator(),))) : Container(),
      ],
    );
  }
}
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final bool signup;
  AuthForm({@required this.signup});
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _signup = false;
  String _email = '', _password = '';

  @override
  void initState() {
    super.initState();
    _signup = widget.signup;
  }

  void inputHandler(String inputField, String value){
    switch(inputField){
      case 'Email':
        setState(() {
          _email = value;
        });
        break;
      case 'Password':
        setState(() {
          _password = value;
        });
        break;
      default:
        break;
    }
  }

  Widget _textField(String title, Function inputHandler){
    return Container(
      margin: EdgeInsets.all(2),
      child: TextFormField(
        style: TextStyle(fontSize: 16),
        onChanged: (value) => inputHandler(title, value),
        decoration: InputDecoration(
          isDense: true,
          labelText: title,
          fillColor: Colors.white,
          border: new OutlineInputBorder(
            borderSide: BorderSide(width: 0),
            borderRadius: const BorderRadius.all(
              const Radius.circular(29.0),
            ),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          filled: true,
          hintText: 'Enter your $title',

        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.greenAccent,
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.80,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Text(!_signup ? "Log In" : "Sign Up", style: Theme.of(context).textTheme.headline1,),
                Container(
                  padding: EdgeInsets.all(30),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        _textField("Email", inputHandler),
                        _textField("Password", inputHandler),
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(onPressed: () => setState(() => _signup = !_signup), child: Text(_signup ? "Log In" : "Sign Up"),),
                    RaisedButton(onPressed: (){}, child: Text(_signup ? "Sign Up" : "Log In"),),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

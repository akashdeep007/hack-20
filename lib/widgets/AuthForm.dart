import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final bool signup;
  AuthForm({@required this.signup});
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  AnimationController _animationController;
  Animation _entry, _delayedEntry, _superDelayedEntry;
  bool _signup;
  String _email = '', _password = '';

  @override
  void initState() {
    super.initState();
    _signup = widget.signup;
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _entry = Tween<double>(begin: -1.0,end : 0).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeIn));
    _delayedEntry = Tween<double>(begin: -1.0,end : 0).animate(CurvedAnimation(parent: _animationController, curve: Interval(0.5, 1, curve: Curves.easeIn)));
    _superDelayedEntry = Tween<double>(begin: -1.0,end : 0).animate(CurvedAnimation(parent: _animationController, curve: Interval(0.7, 1, curve: Curves.easeIn)));
    _animationController.forward();
  }

  void inputHandler(String inputField, String value) {
    switch (inputField) {
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

  Widget _textField(String title, Function inputHandler) {
    return Container(
      margin: EdgeInsets.all(2),
      child: TextFormField(
        obscureText: title == 'Password' ? true : false,
        style: TextStyle(fontSize: 16),
        onChanged: (value) => inputHandler(title, value),
        decoration: InputDecoration(
          isDense: true,
          labelText: title,
          focusColor: Colors.grey,
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
          prefixIcon: Icon(title == "Email" ? Icons.email : Icons.lock),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: Colors.blueGrey[50],
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.80,
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                AnimatedBuilder(
                  animation: _animationController,
                  child: Text(
                    !_signup ? "Log In" : "Sign Up",
                    style: Theme.of(context).textTheme.headline1,
                  ),
                  builder: (context, child) => Transform(
                    transform: Matrix4.translationValues(_entry.value * (width), 0, 0),
                      child: child,
                  ),
                ),
                AnimatedBuilder(
                  animation: _animationController,
                  child: Container(
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
                  builder: (context, child) => Transform(
                    transform: Matrix4.translationValues(_delayedEntry.value * (width), 0, 0),
                    child: child,
                  ),
                ),
                AnimatedBuilder(
                  animation: _animationController,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () => setState(() => _signup = !_signup),
                        child: Text(_signup ? "Log In" : "Sign Up"),
                        color: Colors.yellow,
                        elevation: 3,
                      ),
                      RaisedButton(
                        onPressed: () {},
                        child: Text(_signup ? "Sign Up" : "Log In"),
                        elevation: 3,
                      ),
                    ],
                  ),
                  builder: (context, child) => Transform(
                    transform: Matrix4.translationValues(_superDelayedEntry.value * (width), 0, 0),
                    child: child,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

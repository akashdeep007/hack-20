import 'package:flutter/material.dart';
import 'package:the_robin_app/blocs/AuthService.dart';
import 'package:the_robin_app/widgets/InputField.dart';
import 'package:validators/validators.dart' as validators;

class Signup extends StatefulWidget {
  final Function changeForm;
  Signup({this.changeForm});
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String _email = "", _name = "", _confirm = "", _phone = "", _password = "";
  bool _emailError = false, _nameError = false, _confirmError = false, _passwordError = false, _phoneError = false;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  void inputHandler(String inputField, String value) {
    switch (inputField) {
      case "Email":
        setState(() {
          _email = value;
          _emailError = false;
        });
        break;
      case "Password":
        setState(() {
          _password = value;
          _passwordError = false;
        });
        break;
      case "Confirm Password":
        setState(() {
          _confirm = value;
          _confirmError = false;
        });
        break;
      case "Name":
        setState(() {
          _name = value;
          _nameError = false;
        });
        break;
      case "Phone":
        setState(() {
          _phone = value;
          _phoneError = false;
        });
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
//    final height = MediaQuery.of(context).size.height;
    return Stack(
      children: <Widget>[
        LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    width: width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Register",
                            style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        CustomInputField(icon: Icons.person, inputHandler: inputHandler, error: _nameError, title: "Name"),
                        CustomInputField(icon: Icons.email, inputHandler: inputHandler, error: _emailError, title: "Email"),
                        CustomInputField(icon: Icons.phone, inputHandler: inputHandler, error: _phoneError, title: "Phone"),
                        CustomInputField(icon: Icons.lock, inputHandler: inputHandler, error: _passwordError, title: "Password", isObsecure: true,),
                        CustomInputField(icon: Icons.lock, inputHandler: inputHandler, error: _confirmError, title: "Confirm Password", isObsecure: true,),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Column(
                    children: <Widget>[
                      RaisedButton(
                        child: Text("Register"),
                        onPressed: () async {
                          if(_name.length <= 0) setState(() => _nameError = true);
                          if(!validators.isEmail(_email.trim())) setState(() => _emailError = true);
                          if(!validators.isNumeric(_phone.trim()) || _phone.trim().length != 10) setState(() => _phoneError = true);
                          if(_password.trim().length <= 8 ) setState(() => _passwordError = true);
                          if(_password.trim() != _confirm.trim()) setState(() => _confirmError = true);
                          if(_confirm.trim().length <= 8) setState(() => _confirmError = true);
                          if(!_nameError && !_confirmError && !_phoneError && !_passwordError && !_emailError){
                            setState(() => isLoading = true);
                            await _auth.registerWithEmailAndPassword(_name, _email, _phone, _password);
                            setState(() => isLoading = false);

                          }
                        },
                      ),
                      SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Already Have an Account?",
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          InkWell(
                              onTap: () => widget.changeForm(),
                              child: Text(
                                "Login",
                                style: TextStyle(fontSize: 14, color: Colors.green),
                              ))
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        isLoading ? Center(child: CircularProgressIndicator(),) : Container()
      ],
    );
  }
}

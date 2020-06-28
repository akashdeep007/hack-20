import 'package:flutter/material.dart';
import 'package:the_robin_app/blocs/AuthService.dart';
import 'package:the_robin_app/widgets/CustomCircles.dart';
import 'package:the_robin_app/widgets/Login.dart';

class Signup extends StatefulWidget {
  Function changeForm;
  Signup({this.changeForm});
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  String _email = "", _name = "", _confirm = "", _phone = "", _password = "";
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  _buildFormField(String title, Function inputHandler, IconData icon) {
    return Container(
      height: 45,
      margin: EdgeInsets.all(5),
      child: Material(
        borderRadius: BorderRadius.circular(29),
        shadowColor: Colors.grey,
        elevation: 6,
        child: TextFormField(
          obscureText: title.split(" ").last == "Password",
          style: TextStyle(fontSize: 16),
          onChanged: (value) => inputHandler(title, value),
          decoration: InputDecoration(
            labelText: title,
            floatingLabelBehavior: FloatingLabelBehavior.never,
            isDense: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(29)),
            prefixIcon: Icon(icon),
          ),
        ),
      ),
    );
  }

  void inputHandler(String inputField, String value) {
    switch (inputField) {
      case "Email":
        setState(() => _email = value);
        break;
      case "Password":
        setState(() => _password = value);
        break;
      case "Confirm Password":
        setState(() => _confirm = value);
        break;
      case "Name":
        setState(() => _name = value);
        break;
      case "Phone":
        setState(() => _phone = value);
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 10),
          width: width,
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
        Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              _buildFormField("Name", inputHandler, Icons.person),
              _buildFormField("Email", inputHandler, Icons.email),
              _buildFormField("Phone", inputHandler, Icons.phone),
              _buildFormField("Password", inputHandler, Icons.lock),
              _buildFormField("Confirm Password", inputHandler, Icons.lock),
            ],
          ),
        ),
        Column(
          children: <Widget>[
            RaisedButton(
              child: Text("Register"),
              onPressed: (){
                if(_formKey.currentState.validate()){
                  _auth.registerWithEmailAndPassword(_name, _email, _phone, _password);
                }
              },
            ),
            SizedBox(
              height: 10,
            ),
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
    );
  }
}

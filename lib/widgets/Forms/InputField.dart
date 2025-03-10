import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function inputHandler;
  final bool error;
  final bool isObsecure;
  final bool date;

  const CustomInputField(
      {Key key,
      this.title,
      this.icon,
      this.inputHandler,
      this.error,
      this.isObsecure = false,
      this.date = false})
      : super(key: key);

  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(5),
        child: Material(
          color: error ? Colors.red[100] : Colors.white,
          borderRadius: BorderRadius.circular(29),
          elevation: 6,
          child: TextFormField(
            obscureText: isObsecure,
            onChanged: (value) {
              inputHandler(title, value);
            },
            decoration: InputDecoration(
              labelText: title,
              prefixIcon: Icon(
                icon,
                size: 20,
                color: error ? Colors.red : Colors.green,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              isDense: true,
              contentPadding: EdgeInsets.all(5),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none),
            ),
          ),
        ));
  }
}


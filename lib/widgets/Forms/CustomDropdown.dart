import 'package:flutter/material.dart';


class CustomDropdown extends StatelessWidget {
  final Function inputHandler;
  CustomDropdown({this.inputHandler});
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(5),
      width: width,
      height: 50,
      child: Material(
        shadowColor: Colors.grey,
        elevation: 4,
        color: Colors.white,
        borderRadius: BorderRadius.circular(29),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            elevation: 5,
            value: 'money',
            onChanged: (value){
            },
            iconSize: 20,
            icon: Icon(Icons.donut_large),
            items: [
              DropdownMenuItem(child: Text("Money Campaign"), value: 'money',),
              DropdownMenuItem(child: Text("Free Education"), value: 'education',),
              DropdownMenuItem(child: Text("Food Contribution"), value: 'food',),
              DropdownMenuItem(child: Text("Others"), value: 'other',),
            ],
          ),
        ),
      ),
    );
  }
}

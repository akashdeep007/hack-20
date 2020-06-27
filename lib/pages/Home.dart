import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPage,
        onTap: (value) => setState(() => _selectedPage = value),
        items: [
          BottomNavigationBarItem(
            title: Text("Contact"),
            icon: Icon(Icons.question_answer)
          ),
          BottomNavigationBarItem(
              title: Text("Home"),
              icon: Icon(Icons.home)
          ),
          BottomNavigationBarItem(
              title: Text("Profile"),
              icon: Icon(Icons.person)
          )
        ],
      ),
    );
  }
}

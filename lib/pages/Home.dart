import 'package:flutter/material.dart';
import 'package:the_robin_app/blocs/AuthService.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          FlatButton(onPressed: _auth.signOut,color: Colors.white54,child: Text("Log Out", style: TextStyle(color: Colors.white),),),
        ],
      ),
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

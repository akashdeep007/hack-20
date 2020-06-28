import 'package:flutter/material.dart';
import 'package:the_robin_app/pages/Main/Contact.dart';
import 'package:the_robin_app/pages/Main/HomePage.dart';
import 'package:the_robin_app/pages/Main/Profile.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedPage = 1;
  final List<Widget> pages = [
    ContactPage(),
    HomePage(),
    Profile()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPage,
        onTap: (page){
          setState(() {
            _selectedPage = page;
          });
        },
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
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: pages[_selectedPage],
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }
}

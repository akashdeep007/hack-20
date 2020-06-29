import 'package:flutter/material.dart';
import 'package:the_robin_app/pages/Main/Contact.dart';
import 'package:the_robin_app/pages/Main/Home.dart';
import 'package:the_robin_app/pages/Main/Profile.dart';

class Main extends StatefulWidget {
  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  int _selectedPage = 1;
  final List<Widget> pages = [
    Contact(),
    Home(),
    Profile()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        color: Colors.greenAccent[100].withOpacity(.2),
        height: 60,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(29.0),
            topRight: Radius.circular(29.0),
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.green,
            selectedItemColor: Colors.white,
            showUnselectedLabels: false,
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
        ),
      ),
      body: AnimatedSwitcher(
        duration: Duration(milliseconds: 100),
        child: Container(color : Colors.greenAccent[100].withOpacity(.2),child: pages[_selectedPage]),
      ),
    );
  }
}

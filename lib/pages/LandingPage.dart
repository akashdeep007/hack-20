import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  PageController _pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Stack(
          children: <Widget>[
            PageView(
              controller: _pageController,
              children: <Widget>[
                Page(color: Colors.red, text: "Page 1",),
                Page(color: Colors.green, text: "Page 2"),
                Page(color: Colors.yellow, text: "Page 3"),
                Page(color: Colors.blue, text: "Page 4"),
              ],
            ),
            Positioned(
              bottom: 50,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(onPressed: (){

                    }, child: Text("Login"),),
                    RaisedButton(onPressed: (){}, child: Text("Register"),),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class Page extends StatelessWidget {
  final Color color;
  final String text;
  Page({Key key, this.color, this.text}) : super(key : key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(child: Text(text)),
    );
  }
}

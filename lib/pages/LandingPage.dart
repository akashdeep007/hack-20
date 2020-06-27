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
                Container(color: Colors.red,),
                Container(color: Colors.green,),
                Container(color: Colors.yellow,),
                Container(color: Colors.blue,),
              ],
            ),
            Positioned(
              bottom: 50,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(onPressed: (){}, child: Text("Login"),),
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

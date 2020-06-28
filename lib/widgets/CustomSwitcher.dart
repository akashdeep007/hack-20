import 'package:flutter/material.dart';

class CustomSwitcher extends StatelessWidget {
  final bool liveEventPage;
  final Function pageChangeHandler;

  const CustomSwitcher({Key key, this.liveEventPage, this.pageChangeHandler}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20, left: 10, right: 10),
        height : 40,
        width : 200,
        child : Stack(
            children : <Widget>[
              Container(
                  decoration : BoxDecoration(
                    borderRadius : BorderRadius.circular(29),
                    color : Colors.white,
                  ),
              ),
              AnimatedPositioned(
                top : 5,
                left : liveEventPage ? 6 : 103,
                duration : Duration(milliseconds : 200),
                child : Container(
                  decoration : BoxDecoration(
                    color : Colors.green,
                    borderRadius : BorderRadius.circular(29),
                  ),
                  height : 30,
                  width : 90,
                ),
              ),
              Positioned(
                top : 12,
                left : 16,
                child : InkWell(onTap : pageChangeHandler, child: Text("Live Events", style: TextStyle(color: liveEventPage ? Colors.white : Colors.black),),),
              ),
              Positioned(
                top : 12,
                right: 15,
                child : InkWell(onTap : pageChangeHandler, child:  Text("Your Events", style: TextStyle(color: liveEventPage ? Colors.black : Colors.white)),),
              ),

            ]
        )
    );
  }
}

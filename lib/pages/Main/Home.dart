import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_robin_app/models/Event.dart';
import 'package:the_robin_app/widgets/CustomSwitcher.dart';
import 'package:the_robin_app/widgets/EventRegister.dart';
import 'package:the_robin_app/widgets/HomeBackdrop.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _liveEventPage = true;

  void _pageChangeHandler() => setState(() => _liveEventPage = !_liveEventPage);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.miniStartTop,
            floatingActionButton: Container(margin: EdgeInsets.only(top: 108, left: 10),child: FloatingActionButton(child: Icon(Icons.arrow_back_ios), onPressed: () => Navigator.of(context).pop(),)),
            body :Stack(children: <Widget> [CustomPaint(painter: HomeBackdrop(), child: Container(),),EventRegister()]),
        )));
      }, child: Icon(Icons.add),),
      body: Container(
          child: Stack(
        children: <Widget>[
          CustomPaint(
            painter: HomeBackdrop(),
            child: Container(),
          ),
          LayoutBuilder(
            builder: (context, constraints) => SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(children: <Widget>[
                  CustomSwitcher(liveEventPage: _liveEventPage, pageChangeHandler: _pageChangeHandler,),
                  Consumer<List<Event>>(
                    builder: (context, value, _) {
                      return value != null ? ListView.builder(
                      shrinkWrap: true,
                      itemCount: value.length,
                        itemBuilder: (context, index) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                            child: Column(
                              children: <Widget>[
                                Text(value[index].title),
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: value[index].volunteers.length,
                                  itemBuilder: (context, userIndex) => StreamBuilder(
                                    stream: value[index].volunteers[userIndex].snapshots(),
                                    builder: (context, snapshot) {
                                      if(snapshot.hasData){
                                        return Text(snapshot.data['name']);
                                      }
                                      else return Container();
                                    },
                                  ),)
                              ],
                            ),
                          );
                        },
                    ) : Container();
                    }
                  ),
                ]),
              ),
            ),
          ),
        ],
      )),
    );
  }
}




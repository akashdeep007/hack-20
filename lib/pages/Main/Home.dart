import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_robin_app/models/Event.dart';
import 'package:the_robin_app/models/User.dart';
import 'package:the_robin_app/widgets/CustomSwitcher.dart';
import 'package:the_robin_app/widgets/Forms/EventRegister.dart';
import 'package:the_robin_app/widgets/HomeBackdrop.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _liveEventPage = true;

  void _pageChangeHandler(bool page) => setState(() => _liveEventPage = page);
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      floatingActionButton: FloatingActionButton(
        heroTag: "event_register",
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => SafeArea(
                child: Scaffold(
                      body: Stack(children: <Widget>[
                        CustomPaint(
                          painter: HomeBackdrop(),
                          child: Container(),
                        ),
                        Container(color: Colors.greenAccent[100].withOpacity(.2),),
                        EventRegister(user: user,)
                      ]),
                    ),
              )));
        },
        child: Icon(Icons.add),
      ),
      body: Container(
          child: Stack(
        children: <Widget>[
          CustomPaint(
            painter: HomeBackdrop(),
            child: Container(
              color: Colors.greenAccent[100].withOpacity(.2),
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) => ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Stack(children: <Widget>[
                Consumer<List<Event>>(builder: (context, value, _) {
                  return value != null
                      ? SingleChildScrollView(
                        child: Container(

                            margin: EdgeInsets.only(left: 10, right: 10, top: 100),
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: value.length,
                                itemBuilder: (context, index) {
//                                  print(value[index].addedby);
//                                  print("Curr " + user.id.toString());
                                  if(!_liveEventPage){
                                    if(value[index].addedby != user.id.toString()){
                                      return Container();
                                    }
                                  }
                                  return EventTile(data: value[index],);
                                }),
                          ),
                      )
                      : Container();
                }),
                Align(
                  alignment: Alignment.topCenter,
                  child: CustomSwitcher(
                    liveEventPage: _liveEventPage,
                    pageChangeHandler: _pageChangeHandler,
                  ),
                ),
              ]),
            ),
          ),
        ],
      )),
    );
  }
}

class EventTile extends StatelessWidget {
  EventTile({Key key, this.data}) : super(key: key);
  final data;
  @override
  Widget build(BuildContext context) {
    IconData _icon;
    switch(data.type.toLowerCase()){
      case 'food':
        _icon = Icons.fastfood;
        break;
      case 'education':
        _icon = Icons.school;
        break;
      default:
        break;
    }
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Material(
        key: key,
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(5)),
        child: ExpansionTile(
          leading: Container(height: MediaQuery.of(context).size.height,child: Icon(_icon, color: Colors.green,)),
          initiallyExpanded: false,
          title: Text(data.title),
          subtitle: Text(data.date.toString()),
          children: <Widget>[
            Text(data.description, textAlign: TextAlign.left,),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: data.volunteers.length,
              itemBuilder: (context, userIndex) => StreamBuilder(
                stream: data.volunteers[userIndex].snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(snapshot.data['name']),
                    );
                  } else
                    return Container();
                },
              ),
            ),
            Container(
              height: 40,
              margin: EdgeInsets.only(top: 5, bottom: 10),
              child: RaisedButton(
                onPressed: (){},
                child: Text("Volunteer"),
              ),
            )
          ],
        ),
      ),
    );
  }
}

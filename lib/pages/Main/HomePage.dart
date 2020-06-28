import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    String event = "";
    String location = '';

    createevents() {
      DocumentReference documentReference =
          Firestore.instance.collection("Event").document(event);

      //Map
      Map<String, String> events = {"event": event, "location": location};

      documentReference.setData(events).whenComplete(() {
        print("$event created");
      });
    }

    deleteevents(item) {
      DocumentReference documentReference =
          Firestore.instance.collection("Event").document(item);

      documentReference.delete().whenComplete(() {
        print("$item deleted");
      });
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  title: Text("Add Event"),
                  content: Column(
                    children: <Widget>[
                      TextField(
                        onChanged: (String value) {
                          event = value;
                        },
                      ),
                      TextField(
                        onChanged: (String value) {
                          location = value;
                        },
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                        onPressed: () {
                          createevents();

                          Navigator.of(context).pop();
                        },
                        child: Text("Add"))
                  ],
                );
              });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder(
          stream: Firestore.instance.collection("Event").snapshots(),
          builder: (context, snapshots) {
            if (snapshots.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshots.data.documents.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot documentSnapshot =
                        snapshots.data.documents[index];
                    return Dismissible(
                        onDismissed: (direction) {
                          deleteevents(documentSnapshot["event"]);
                        },
                        key: Key(documentSnapshot["event"]),
                        child: Card(
                          elevation: 4,
                          margin: EdgeInsets.all(8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          child: ListTile(
                            title: Text(documentSnapshot["event"]),
                            trailing: IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  deleteevents(documentSnapshot["event"]);
                                }),
                          ),
                        ));
                  });
            } else {
              return Align(
                alignment: FractionalOffset.bottomCenter,
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

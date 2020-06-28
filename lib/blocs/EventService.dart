import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_robin_app/models/Event.dart';

class EventService {
  final uid;
  EventService({this.uid});
  final CollectionReference eventCollection =
  Firestore.instance.collection('events');
  final CollectionReference userCollection =
  Firestore.instance.collection('users');

  Stream<List<Event>> get events =>
      eventCollection.snapshots().map(_eventListFromSnapshot);
  Stream<Event> get event {
    return eventCollection.document(uid).snapshots().map(_eventFromSnapshot);
  }

  Future<void> addVolunteer(String eventId, String userId, String name) async{
      await eventCollection.document(eventId).setData({'volunteers' : [{'name' : name, 'id' : userId}],}, merge: true);
  }

  Future<void> deleteEvent(String eventId) async {
    await eventCollection.document(eventId).delete();
  }


  Future<void> updateEvent(String donorName, String title, String type, String description, String location, String date, String contact) async {
    await eventCollection.add({
      'donorName' : donorName,
      'title' : title,
      'description' : description,
      'contact' : contact,
      'type' : type,
      'location' : location,
      'date' : date,
      'addedby' : uid,
      'volunteers' : []
    });
  }

  List<Event> _eventListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Event(
         eventID: doc.documentID,
          donorName: doc.data['donorName'] ?? '',
          title: doc.data['title'] ?? '',
          description: doc.data['description'] ?? '',
          location :doc.data['location'] ?? '',
          contact :doc.data['contact'] ?? '',
          date:doc.data['date'] ?? '',
          type : doc.data['type'] ?? '',
          addedby: doc.data['addedby'] ?? '',
          volunteers: (doc.data['volunteers'])
      );
    }).toList();
  }

  Event _eventFromSnapshot(DocumentSnapshot doc) {
    return Event(
      eventID: doc.documentID,
      donorName: doc.data['donorName'] ?? '',
      title: doc.data['title'] ?? '',
      description: doc.data['description'] ?? '',
      location :doc.data['location'] ?? '',
      contact :doc.data['contact'] ?? '',
      date:doc.data['date'] ?? '',
      type : doc.data['type'] ?? '',
      addedby: doc.data['type'] ?? '',
      volunteers: doc.data['volunteers']
    );
  }
}

import 'package:the_robin_app/models/User.dart';

class Event{
  final String eventID;
  final String donorName;
  final String title;
  final String type;
  final String description;
  final String location;
  final String date;
  final String contact;
  final String addedby;
  final volunteers;

  Event({this.eventID, this.donorName, this.title, this.type, this.description, this.location, this.date, this.contact, this.addedby, this.volunteers});
}
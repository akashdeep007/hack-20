import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final uid;
  DatabaseService({this.uid});
  final CollectionReference userCollection = Firestore.instance.collection('users');

  Stream<List<User>> get users => return userCollection.snapshots().map(_userListFromSnapshot);


  List<UserData> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return UserData(
          name: doc.data['name'] ?? "",
          email: doc.data['email'] ?? "",
    }).toList();
  }


}
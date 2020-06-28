import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:the_robin_app/models/User.dart';

class DatabaseService {
  final uid;
  DatabaseService({this.uid});
  final CollectionReference userCollection =
      Firestore.instance.collection('users');

  Stream<List<User>> get users =>
      userCollection.snapshots().map(_userListFromSnapshot);
  Stream<User> get user {
    return userCollection.document(uid).snapshots().map(_userFromSnapshot);
  }


  Future<void> updateUser(String name, String email, String phone) async {
    await userCollection.document(uid).setData({
      'name' : name,
      'email' : email,
      'phone' : phone,
      'role' : 'volunteer'
    });
  }

  List<User> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return User(
          name: doc.data['name'] ?? "",
          email: doc.data['email'] ?? "",
          phone: doc.data['phone'] ?? "",
          role : doc.data['role'] ?? "");
    }).toList();
  }

  User _userFromSnapshot(DocumentSnapshot doc) {
    return User(
        name: doc.data['name'] ?? "",
        email: doc.data['email'] ?? "",
        phone: doc.data['phone'] ?? "",
        role : doc.data['role'] ?? ""
    );
  }
}

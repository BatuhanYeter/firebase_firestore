import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth_trying/models/user.dart';
import 'package:firebase_auth_trying/models/user_data.dart';

class DatabaseService {
  // todo: collection reference
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('users');
  final String uid;

  DatabaseService({this.uid});

  Future updateUserData(String name, String email, String password) async {
    return await userCollection.doc(uid).set({
      'name': name,
      'email': email,
      'password': password,
    });
  }

  // user list from snapshot
  List<UserData> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return UserData(
        name: doc.data()['name'] ?? "",
        email: doc.data()['email'] ?? "",
        password: doc.data()['password'] ?? "",
      );
    }).toList();
  }
  // single user data from snapshot
  SingleUserData _singleUserDataFromSnapshot(DocumentSnapshot snapshot) {
    return SingleUserData(
      uid: uid,
      name: snapshot.data()['name'],
      email: snapshot.data()['email'],
      password: snapshot.data()['password'],
    );
  }


  // when we create this kind of thing, we need to go to the page we will use
  // this data and cover the widget with the provider
  // such as: home_page.dart->return StreamProvider<QuerySnapshot>.value(
  //                          value: DatabaseService().users -> so we specified that
  //                          we want this stream to be used
  Stream<List<UserData>> get userData {
    return userCollection.snapshots().map(_userListFromSnapshot);
  }

  // get single user doc stream
  Stream<SingleUserData> get singleUserData {
    return userCollection.doc(uid).snapshots().map(_singleUserDataFromSnapshot);
  }

  Future<DocumentSnapshot> getFutureData() async {
    return await userCollection.doc(uid).get();
  }
}

import 'package:chatmaxapp/providers/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class Users with ChangeNotifier {
  List<User> _users = [];

  List<User> get users {
    return _users;
  }

  Future<void> fetchAllUsers() async {
    QuerySnapshot querySnapshot =
        await Firestore.instance.collection('users').getDocuments();
    List<DocumentSnapshot> docSnapshot = querySnapshot.documents;
    _users = docSnapshot
        .map((e) => User(
              email: e.data['email'],
              fullName: e.data['fullName'],
              image: e.data['imagePath'],
            ))
        .toList();
        notifyListeners();
  }
}

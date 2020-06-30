import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth with ChangeNotifier {
  String userId;
  String email;
  String fullName;
  String imagePath;

  Auth({this.userId, this.email});

  Future<bool> isAuth() async {
    bool res = !(FirebaseAuth.instance.currentUser() == null);
    if (res) {
      final user = await FirebaseAuth.instance.currentUser();
      email = user.email;
      userId = user.uid;
      final DocumentReference documentReference =
          Firestore.instance.collection("users").document(userId);
      await documentReference
          .get()
          .then<dynamic>((DocumentSnapshot snapshot) async {
        fullName = snapshot.data['fullName'];
        imagePath = snapshot.data['imagePath'];
      });
      print('IA ' + email + fullName);
      notifyListeners();
    }
    return res;
  }

  Future<String> signUp(
      String email, String password, String image, String name) async {
    try {
      AuthResult res = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      email = res.user.email;
      userId = res.user.uid;
      imagePath = image;
      fullName = name;
      Firestore.instance.collection("users").document(userId).setData({
        'uid': userId,
        'email': email,
        'fullName': fullName,
        'imagePath': imagePath
      });
      notifyListeners();
    } catch (e) {
      return e.toString();
    }
    return "Clean";
  }

  Future<String> signIn(String email, String password) async {
    try {
      AuthResult res = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      email = res.user.email;
      userId = res.user.uid;
      final DocumentReference documentReference =
          Firestore.instance.collection("users").document(userId);
      await documentReference
          .get()
          .then<dynamic>((DocumentSnapshot snapshot) async {
        fullName = snapshot.data['fullName'];
        imagePath = snapshot.data['imagePath'];
      });
      print('SI' + email + fullName);
      notifyListeners();
    } catch (e) {
      return e.toString();
    }
    return "Clean";
  }

  logout() async {
    email = null;
    userId = null;
    fullName = null;
    imagePath = null;
    return await FirebaseAuth.instance.signOut();
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserUID with ChangeNotifier{

  String uidlelo;
   String get getUserUID => uidlelo;
   void creates() async {
    try {
      // getCurrentI
      final uid = (await FirebaseAuth.instance.currentUser()).uid;
      
      uidlelo =uid;
      print("object");
       notifyListeners();
      
    } catch (e) {
      print(e);
    }
  }
}
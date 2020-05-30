import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class GirliesFavorities extends StatefulWidget {
  @override
  _GirliesFavoritiesState createState() => _GirliesFavoritiesState();
}

class _GirliesFavoritiesState extends State<GirliesFavorities> {
  final Firestore firestore = Firestore.instance;
  TextEditingController _controller;
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  String name = "";
  void create() async {
    try {
      // getCurrentI
      final uid = (await FirebaseAuth.instance.currentUser()).uid;
      await firestore
          .collection('userData')
          .document(uid)
          .collection('Customer Coll')
          .document('Cust Doc')
          .setData({
        'firstName': name,
        'lastName': name,
      });
      //'firstName': name,
      // 'lastName': name,
      //);
      //await firestore.collection('userData').document(uid).setData({
      //'firstName': name,
      //'lastName': name,
      //}
      // );
    } catch (e) {
      print(e);
    }
  }

  void read() async {
    DocumentSnapshot documentSnapshot;
    try {
      print((await FirebaseAuth.instance.currentUser()).uid);
      final uid = (await FirebaseAuth.instance.currentUser()).uid;
      documentSnapshot = await firestore
          .collection('userData')
          .document(uid)
          .collection('Customer Coll')
          .document('Cust Doc')
          .get();

      // documentSnapshot = await firestore.collection('users').document('testUser').get();
      print(documentSnapshot.data);
      Text(documentSnapshot.data["lastName"]);

      //Text(snapshot.data.Document[0]['firstName']);
      ListView.builder(
        shrinkWrap: true,
        itemCount: 2,
        itemBuilder: (BuildContext context, int index) {
          return Text(documentSnapshot.data['firstName']);
        },
      );
    } catch (e) {
      print(e);
    }
  }

  void update() async {
    try {
     // final uid = await Provider.of(context).auth.getCurrentID();
      //firestore.collection('users').document('testUser').updateData({
      // 'firstName': 'testUpdated',
      // }
      //);
      firestore
          .collection('userData')
          .document("uid")
          .collection('Customer Coll')
          .document('Cust Doc')
          .setData({
        'firstName': 'Jai Hanuman',
      });
    } catch (e) {
      print(e);
    }
  }

  void delete() async {
    try {
      final uid = await Provider.of(context).auth.getCurrentID();
      //firestore.collection('users').document('testUser').delete();
      firestore
          .collection('userData')
          .document(uid)
          .collection('Customer Coll')
          .document('Cust Doc')
          .delete();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text("My Favorites"),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              StreamBuilder(
                //stream: Firestore.instance.collection('users').snapshots() ,
                //initialData: initialData ,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return Text(' loading plz wait..');
                  return Column(children: <Widget>[
                    Text(snapshot.data.documents[0]['firstName']),
                    Text(snapshot.data.documents[0]['lastName']),
                  ]);
                },
              ),
              Text(name),
              Container(
                child: TextField(
                  controller: _controller,
                  //keyboardType: TextInputType.phone,
                  decoration: InputDecoration(hintText: 'Enter '),
                  onChanged: (text) {
                    print("First text field: $_controller.text");
                    name = _controller.text;
                  },
                ),
                padding: EdgeInsets.all(32),
              ),
              Container(
                width: double.infinity,
                child: FlatButton(
                  child: Text("click me"),
                  color: Colors.red,
                  onPressed: () {
                    name = _controller.text;
                  },
                ),
                padding: EdgeInsets.all(32),
              ),
              RaisedButton(
                child: Text("Create"),
                onPressed: create,
              ),
              RaisedButton(
                child: Text("Read"),
                onPressed: read,
              ),
              RaisedButton(
                child: Text("Update"),
                onPressed: update,
              ),
              RaisedButton(
                child: Text("Delete"),
                onPressed: delete,
              ),
            ]),
      ),
    );
  }
}

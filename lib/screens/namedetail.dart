import 'dart:async';
//import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firewebauth/screens/mobile_storage.dart';
import 'package:firewebauth/utils/global.dart';
import 'package:firewebauth/widgets/imagespecial.dart';
import 'package:flutter/material.dart';

class Namedetail extends StatefulWidget {
  final String value;
  Namedetail({Key key, this.value}) : super(key: key);

  @override
  _NamedetailState createState() => _NamedetailState();
}

class _NamedetailState extends State<Namedetail> {
  Image ms;

  final Firestore firestore = Firestore.instance;
  TextEditingController _controllers;
  TextEditingController _controllers2;
  TextEditingController _controllers3;
  TextEditingController _controllers4;
  TextEditingController _controllers5;
  TextEditingController _controllers6;
  TextEditingController _controllers7;
  String names = "";
  String names2 = "";

  StreamSubscription _subscription;

  void uidkliye() async {
    final uid = (await FirebaseAuth.instance.currentUser()).uid;
    _subscription = firestore
        .collection('userData')
        .document(uid)
        .collection('Customer Coll')
        .document('Cust Doc')
        .snapshots()
        .listen(
            (DocumentSnapshot snapshot) => this._onDatabaseUpdate(snapshot));
  }

  Future<Widget> _getImages(BuildContext context) async {
    await FireStorageService.loadImage(context).then((downloadUrl) {
      ms = Image.network(
        downloadUrl.toString(),
        fit: BoxFit.scaleDown,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes
                  : null,
            ),
          );
        },
      );
    });
    return ms;
  }

  void initState() {
    uidkliye();
    //FirebaseAuth.instance.onAuthStateChanged;

    super.initState();
    _controllers = TextEditingController();
    _controllers2 = TextEditingController();
    _controllers3 = TextEditingController();
    _controllers4 = TextEditingController();
    _controllers5 = TextEditingController();
    _controllers6 = TextEditingController();
    _controllers7 = TextEditingController();
  }

  @override
  void dispose() {
    _controllers.dispose();
    _controllers2.dispose();
    _controllers3.dispose();
    _controllers4.dispose();
    _controllers5.dispose();
    _controllers6.dispose();
    _controllers7.dispose();

    if (_subscription != null) _subscription.cancel();

    super.dispose();
  }

  /* Stream<QuerySnapshot> getUsersTripsStreamSnapshots(
            BuildContext context) async* {
           // final uid = await Provider.of(context).auth.getCurrentID();
            final uid = (await FirebaseAuth.instance.currentUser()).uid;
          yield* Firestore.instance.collection('userData').document(uid).collection(
        'Customer Coll').snapshots();

          }*/

  void _onDatabaseUpdate(DocumentSnapshot snapshot) {
    setState(() {
      _controllers.text = snapshot.data["firstName"];
      print(_controllers.text);
      _controllers2.text = snapshot.data["AddLine1"];
      print(_controllers2.text);
      _controllers3.text = snapshot.data["AddLine2"];
      print(_controllers3.text);
      _controllers4.text = snapshot.data["landmark"];
      print(_controllers4.text);
      _controllers5.text = snapshot.data["city"];
      print(_controllers5.text);
      _controllers6.text = snapshot.data["state"];
      print(_controllers6.text);
      _controllers7.text = snapshot.data["pincode"];
      print(_controllers7.text);
    });
  }

  void create() async {
    try {
      print((await FirebaseAuth.instance.currentUser()).uid);
      final uid = (await FirebaseAuth.instance.currentUser()).uid;
      await firestore
          .collection('userData')
          .document(uid)
          .collection('Customer Coll')
          .document('Cust Doc')
          .setData({
        'firstName': _controllers.text,
        'AddLine1': _controllers2.text,
        'AddLine2': _controllers3.text,
        'landmark': _controllers4.text,
        'city': _controllers5.text,
        'state': _controllers6.text,
        'pincode': _controllers7.text,
        "mobile": widget.value.toString()
      });
      //firestore.collection('userData').document(uid).collection('Customer Coll').
      //document('Cust Doc').snapshots().listen((DocumentSnapshot snapshot) =>
      //this._onDatabaseUpdate(snapshot) );
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkblue,

      //backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(title: Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              Container(
                  child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => UploadImageeg()));
                },
                child: FutureBuilder(
                    future: _getImages(context),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done)
                        return CircleAvatar(
                            backgroundColor: Colors.blue,
                            radius: 100.0,
                            backgroundImage: snapshot.data != null
                                // m.image
                                ? snapshot.data.image
                                : AssetImage("images/doctor.png"));

                      if (snapshot.connectionState == ConnectionState.waiting)
                        return Container(
                            height: MediaQuery.of(context).size.height / 1.25,
                            width: MediaQuery.of(context).size.width / 1.25,
                            child: CircularProgressIndicator());

                      return Container();
                    }),
              )),
              SizedBox(height: 50),
              TextField(
                style: TextStyle(fontSize: 20.0, color: Colors.black),
                controller: _controllers,
                //keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    prefixIcon: Icon(Icons.person),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Enter Name ',
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blueAccent, width: 32.0),
                        borderRadius: BorderRadius.circular(25.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white, width: 32.0),
                        borderRadius: BorderRadius.circular(25.0))),
                onChanged: (text) {
                  print("First text field: $_controllers.text");
                  names = _controllers.text;
                },
              ),
              new SizedBox(
                height: 10.0,
              ),
              Text(
                "Address",
                style: productTitleStyle,
              ),

              SizedBox(
                height: 10.0,
              ),
              TextField(
                style: TextStyle(fontSize: 15.0, color: Colors.blueAccent),
                controller: _controllers2,
                //keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    prefixIcon: Icon(Icons.add_location),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Address Line 1  ',
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blueAccent, width: 32.0),
                        borderRadius: BorderRadius.circular(25.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white, width: 32.0),
                        borderRadius: BorderRadius.circular(25.0))),
                onChanged: (text) {
                  print("First text field: $_controllers2.text");
                  names2 = _controllers2.text;
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                style: TextStyle(fontSize: 15.0, color: Colors.blueAccent),
                controller: _controllers3,
                //keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    prefixIcon: Icon(Icons.add_location),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Address Line 2 ',
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blueAccent, width: 32.0),
                        borderRadius: BorderRadius.circular(25.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white, width: 32.0),
                        borderRadius: BorderRadius.circular(25.0))),
                onChanged: (text) {
                  print("First text field: $_controllers3.text");
                  names2 = _controllers3.text;
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                style: TextStyle(fontSize: 15.0, color: Colors.blueAccent),
                controller: _controllers4,
                //keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    prefixIcon: Icon(Icons.add_location),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Landmark ',
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blueAccent, width: 32.0),
                        borderRadius: BorderRadius.circular(25.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white, width: 32.0),
                        borderRadius: BorderRadius.circular(25.0))),
                onChanged: (text) {
                  print("First text field: $_controllers4.text");
                  names2 = _controllers4.text;
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                style: TextStyle(fontSize: 15.0, color: Colors.blueAccent),
                controller: _controllers5,
                //keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    prefixIcon: Icon(Icons.add_location),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'City ',
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blueAccent, width: 32.0),
                        borderRadius: BorderRadius.circular(25.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white, width: 32.0),
                        borderRadius: BorderRadius.circular(25.0))),
                onChanged: (text) {
                  print("First text field: $_controllers5.text");
                  names2 = _controllers5.text;
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                style: TextStyle(fontSize: 15.0, color: Colors.blueAccent),
                controller: _controllers6,
                //keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    prefixIcon: Icon(Icons.add_location),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'State',
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blueAccent, width: 32.0),
                        borderRadius: BorderRadius.circular(25.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white, width: 32.0),
                        borderRadius: BorderRadius.circular(25.0))),
                onChanged: (text) {
                  print("First text field: $_controllers6.text");
                  names2 = _controllers6.text;
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                style: TextStyle(fontSize: 15.0, color: Colors.blueAccent),
                controller: _controllers7,
                //keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                    prefixIcon: Icon(Icons.add_location),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Pincode ',
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.blueAccent, width: 32.0),
                        borderRadius: BorderRadius.circular(25.0)),
                    focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white, width: 32.0),
                        borderRadius: BorderRadius.circular(25.0))),
                onChanged: (text) {
                  print("First text field: $_controllers7.text");
                  names2 = _controllers7.text;
                },
              ),
              SizedBox(
                height: 10.0,
              ),
              //Text("${widget.value}"),
              //SizedBox(height:20.0),
              Padding(
                padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                child: Container(
                  height: 50.0,
                  child: RaisedButton(
                    elevation: 20,
                    //color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0),
                      /*side: BorderSide(color: Colors.red)*/
                    ),
                    padding: EdgeInsets.all(0.0),
                    child: Ink(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xff374ABE), Color(0xff64B6FF)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(30.0)),
                        child: Container(
                            constraints: BoxConstraints(
                                maxWidth: 300.0, minHeight: 50.0),
                            alignment: Alignment.center,
                            child: Center(
                                child: Text("Save",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Helvetica",
                                        fontSize: 25))))),
                    onPressed: () {
                      create();
                      return showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              // Retrieve the text the that user has entered by using the
                              // TextEditingController.
                              content: Text("Saved Successfully"),
                            );
                          });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

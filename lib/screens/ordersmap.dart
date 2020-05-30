import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firewebauth/constants/strings.dart';
import 'package:firewebauth/models/orders.dart';
import 'package:flutter/cupertino.dart';
//import 'package:firewebauth/widgets/provider.dart';
//import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Forests extends StatefulWidget {
  @override
  _ForestsState createState() => _ForestsState();
}

class _ForestsState extends State<Forests> {
  final Firestore firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Order Notifications")),
      body: Container(
          child: Center(
            child: Column(
      children: <Widget>[
        Flexible(
                  child: StreamBuilder(
              stream: FirebaseAuth.instance.onAuthStateChanged,
              builder: (context, snapshot) {
                return Center(
                  child: StreamBuilder(
                    stream: getUsersTripsStreamSnapshots(context),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData)
                        return const Text("Loading...");
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.documents.length,
                          padding: const EdgeInsets.only(top: 5.0),
                          itemBuilder: (context, int index) {
                            DocumentSnapshot ds =
                                snapshot.data.documents[index];
                                 Orders _orders = Orders.fromMap(ds.data);
                            return Row(
                              textDirection: TextDirection.ltr,
                              children: <Widget>[
                                Expanded(
                                  child: Container(
                                     color: Colors.white54,
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          child: Column(children: <Widget>[
                                            Card(
                                              
                                              margin: EdgeInsets.all(8.0),
                                              //color: darkblue,
                                             borderOnForeground: true,
                                              elevation: 5.0,
                                              shadowColor: Colors.pink,
                                              child: ListTile(
                                                leading: CircleAvatar(
                                                  child: Icon(
                                                    Icons.history,
                                                    color: Colors.white,
                                                    size: 20.0,
                                                  ),
                                                ),
                                                /*title: new Text(
                                                  ds["Item Name"],
                                                ), */
                                                title: new Text( _orders.productname
                                                 /* ds["Item Name"]*/,
                                                ),
                                                subtitle: Text(
                                                 /* ds["Item Price"]*/ _orders.productprice
                                                      .toString(),
                                                ),
                                                onTap: () {},
                                              ),
                                            ),
                                          ]),
                                        ),
                                        //Text(ds["Item Name"]),
                                        //Text(ds["Item Price"].toString()),
                                      ],
                                    ),
                                  ),
                                ),
                                //Expanded (child:Text(ds["lastName"]) ),
                                //Expanded (child:Text(ds["last-field"].toString()) ),
                                //Text(snapshot.data.documents[index]),
                              ],
                            );
                          });
                    },
                  ),
                );
              }),
        ),
      ],
            ),
          ),
        ),
    );
  }

  Stream<QuerySnapshot> getUsersTripsStreamSnapshots(
      BuildContext context) async* {
    // final uid = await Provider.of(context).auth.getCurrentID();
    final uid = (await FirebaseAuth.instance.currentUser()).uid;
    yield* Firestore.instance
        .collection('Order')
        .document(uid)
        .collection('Order Colls').orderBy(TIMESTAMP_FIELD, descending: true)
        .snapshots();
  }

  void mm() async {
    DocumentSnapshot documentSnapshot;
    try {
      print((await FirebaseAuth.instance.currentUser()).uid);
      final uid = (await FirebaseAuth.instance.currentUser()).uid;
      documentSnapshot = await firestore
          .collection('Order')
          .document(uid)
          .collection('Order Coll')
          .document('Order Doc')
          .get();
      // documentSnapshot = await firestore.collection('users').document('testUser').get();
      print(documentSnapshot.data);

      //Text(snapshot.data.Document[0]['firstName']);

    } catch (e) {
      print(e);
    }
  }
}

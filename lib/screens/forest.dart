import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
//import 'package:firewebauth/widgets/provider.dart';
//import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class Forest extends StatefulWidget {
  @override
  _ForestState createState() => _ForestState();
}

class _ForestState extends State<Forest> {
  final Firestore firestore = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Orderggg History")),
      body: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              StreamBuilder(
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
                                                    title: new Text(
                                                      ds["Item Name"],
                                                    ),
                                                    subtitle: Text(
                                                      ds["Item Price"]
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
        .collection('Order Coll')
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

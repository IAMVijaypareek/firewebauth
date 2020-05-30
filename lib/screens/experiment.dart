import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class Experiment extends StatefulWidget {
  @override
  _ExperimentState createState() => _ExperimentState();
}

class _ExperimentState extends State<Experiment> {
  @override
  Widget build(BuildContext context0) {
    return Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance.collection('Order').snapshots() ,
        //initialData: initialData ,
        builder: (context,snapshot){
         if(!snapshot.hasData) return Text(' loading plz wait..');
         return Column(
           children:<Widget>[
                 Text(snapshot.data.documents[0]['firstName']),
                  //Text(snapshot.data.documents[0]['lastName']),
           ]
         );
        },
      ),
      
    );
  }
}
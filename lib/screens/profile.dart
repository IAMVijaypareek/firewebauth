import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile  extends StatefulWidget {
  

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile > {

  
    
 TextEditingController emailcntrlr = new TextEditingController();
 TextEditingController passwordcntrl = new TextEditingController();
 
   String result = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
     appBar: AppBar(
       title:Text("Profile Setting"),
     ),
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(result),
          Container(
            padding:EdgeInsets.all(5.0),
            child: TextField(
              style: TextStyle(
                fontSize:15.0,
                color: Colors.blueAccent
              ),
              controller: emailcntrlr,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                prefixIcon: Icon(Icons.person),
                errorStyle: TextStyle(color:Colors.deepOrange),
                filled: true,
                fillColor: Colors.white,
                //border: OutlineInputBorder(),
                labelText: "Name",
                hintText: "Name",
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent, width: 32.0),
                    borderRadius: BorderRadius.circular(25.0)
                    ),
                    focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 32.0),
                    borderRadius: BorderRadius.circular(25.0))
              ),
              keyboardType: TextInputType.emailAddress,
              ),
          ),
          Container(
            padding:EdgeInsets.all(5.0),
            child: TextField(
              style: TextStyle(
                fontSize:15.0,
              color: Colors.blueAccent,
              ),
              controller: passwordcntrl,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                prefixIcon: Icon(Icons.lock),
                errorStyle: TextStyle(color:Colors.deepOrange),
                filled: true,
                fillColor: Colors.white,
                //border: OutlineInputBorder(),
                labelText: "Address ",
                hintText: "Address",
                 border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blueAccent, width: 32.0),
                    borderRadius: BorderRadius.circular(25.0)
                    ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white, width: 32.0),
                    borderRadius: BorderRadius.circular(25.0))
              
              ),
              keyboardType: TextInputType.visiblePassword,
              ),
          ),
             RaisedButton( color: Colors.blueGrey,
               child: Text("Signup"),
               onPressed: () async {
                          await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: emailcntrlr.text
                            , password: passwordcntrl.text,
                            ).then((_) {
                              setState(() {
                                result="Success";
                              });
                            }).catchError((){
                              setState(() {
                                 result="Failure";
                              });
                             
                            })
                            ;
                 },)
          

      ],),),
      
    );
  }
}

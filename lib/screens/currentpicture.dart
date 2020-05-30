import 'dart:io';
import 'package:firewebauth/utils/utilities.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firewebauth/resources/firebase_methods.dart';


class CurrentPic extends StatefulWidget {
  @override
  _CurrentPicState createState() => _CurrentPicState();
}

class _CurrentPicState extends State<CurrentPic> {
  File sapleImagesss;
   getImagess() async {
    // var tempImages = await ImagePicker.pickImage(source: ImageSource.gallery);
    var tempImages = await Utils.pickImage(source: ImageSource.gallery);
    setState(() {
      sapleImagesss = tempImages;
    });
     String url =await FirebaseMethods().uploadImageToStorage(sapleImagesss);
     print(url);
     
     Image.network(sapleImagesss.toString());
  }

   enableUploads() {

    
     

    /*final StorageReference firebaseStorageref = FirebaseStorage.instance
        .ref()
        .child('${DateTime.now().millisecondsSinceEpoch}');
    final StorageUploadTask task = firebaseStorageref.putFile(sapleImagesss);
    var url = await (await task.onComplete).ref.getDownloadURL();
    print("object for url");*/
    //print(url);
    //return NetworkImage(url);
  }

  @override
  Widget build(BuildContext context) {
    
    var screenheight = MediaQuery.of(context).size.height;
    var screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text("Image")),
      body: Container(
          child: Column(
        children: <Widget>[
          Container(
              height: screenheight / 3,
              width: screenwidth,
              color: Colors.pink,
              child: Center(
                child: CircleAvatar(
                  radius: screenwidth / 4,
                  backgroundImage: sapleImagesss==null ? NetworkImage('images/doctor.png'):NetworkImage(sapleImagesss.toString(),scale:0.5),
                  
                  child: GestureDetector(
                    onTap: getImagess,
                  ),
                ),
              ))
        ],
      )),
    );
  }
}

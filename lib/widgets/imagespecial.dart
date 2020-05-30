import 'package:firewebauth/provider/image_upload_provider.dart';
import 'package:firewebauth/resources/firebase_methods.dart';
import 'package:firewebauth/screens/mobile_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firewebauth/utils/utilities.dart';
import 'package:provider/provider.dart';

class UploadImageeg extends StatefulWidget {
  @override
  _UploadImageegState createState() => _UploadImageegState();
}

class _UploadImageegState extends State<UploadImageeg> {
  //Utils utils = Utils();
  File sampleImage;
   Image m;
   bool buttonpe =true;

  Future<Widget> _getImage(BuildContext context) async {
    await FireStorageService.loadImage(context).then((downloadUrl) {
      if(downloadUrl!=null)
      {m = Image.network(
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
      );}
      else {
        m=Image.asset("images/coronavirus.png");
      }
    });
    return m;
  }
  Future getImage() async {
    // var tempImages = await ImagePicker.pickImage(source: ImageSource.gallery);
    var tempImages = await Utils.pickImage(source: ImageSource.gallery);
    setState(() {
      sampleImage = tempImages;
    });
  }

  Widget enableUpload() {
    return Container(
        child: Column(
      children: <Widget>[
        CircleAvatar(
          radius: 100.0,
          backgroundImage: sampleImage == null
              ? Text("")
              : Image.file(
                  sampleImage,

                  // height: MediaQuery.of(context).size.height * .75,
                  //width: MediaQuery.of(context).size.width,
                  fit: BoxFit.fill,
                ).image,
        ),
        Center(
          child: RaisedButton(
            elevation: 7.0,
            textColor: Colors.white,
            color: Colors.blue,
            child: buttonpe==true 
            ?Text("upload")
            :Text ("wait..!"),
            onPressed: () async{
              
              //print();
               setState(() {
                 buttonpe = false;
               });
              await FirebaseMethods().uploadImageToStorage(sampleImage);
              return showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              // Retrieve the text the that user has entered by using the
                              // TextEditingController.
                              content:
                              Text("Updated Successfully wait for some time to reflect!!!"),
                            );
                          });
              

              /*Navigator.of(context).push(new MaterialPageRoute(
                  builder: (BuildContext context) => ShowImg()));*/
              //Text(url);
              /* final StorageReference firebaseStorageref =
                  FirebaseStorage.instance.ref().child('${DateTime.now().millisecondsSinceEpoch}');
              final StorageUploadTask task =
                  firebaseStorageref.putFile(sampleImage);
                   var url = await (await task.onComplete).ref.getDownloadURL();
              print("finish");*/
            },
          ),
        )
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
    ImageUploadProvider _imageprovider =
        Provider.of<ImageUploadProvider>(context);
    return Scaffold(
        appBar: AppBar(title: Text("Image")),
        body: Center(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: sampleImage == null
                      ?   FutureBuilder(
                          future: 
                          
                          _getImage(context),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.connectionState == ConnectionState.done)
                              return CircleAvatar(
                                  backgroundColor: Colors.blue,
                                 radius: 100.0,
                                  backgroundImage: snapshot.data != null// m.image
                                  ?snapshot.data.image
                                  :AssetImage("images/doctor.png")
                                  );

                            if (snapshot.connectionState == ConnectionState.waiting)
                              return Container(
                                  //height: MediaQuery.of(context).size.height / 1.25,
                                  //width: MediaQuery.of(context).size.width / 1.25,
                                  child: CircularProgressIndicator());

                            return Container();
                          })
                      : enableUpload(),
                ),
                SizedBox(
                  height: 20.0,
                ),
                FloatingActionButton(
                  onPressed: () {
                    _imageprovider.setToLoading();
                    getImage();
                  },
                  tooltip: 'Add Image',
                  child: Icon(Icons.add),
                ),
              ],
            ),
          ),
        ));
  }
}

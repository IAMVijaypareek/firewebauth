import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class DeailImageScreen extends StatefulWidget {
  final String imgurls;
  DeailImageScreen({this.imgurls});

  @override
  _DeailImageScreenState createState() => _DeailImageScreenState();
}

class _DeailImageScreenState extends State<DeailImageScreen> {
  final List imageList = [
    'https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1566405728-berluti-1566405720.jpg'
  ];

  @override
  Widget build(BuildContext context) {
    imageList.add(widget.imgurls);
    return Scaffold(
        body: Stack(children: <Widget>[
      
          Positioned(
            
            child:  PhotoViewGallery.builder(
  itemCount: imageList.length,
  scrollPhysics: const BouncingScrollPhysics(),
  builder: (BuildContext context, int index) {
    return PhotoViewGalleryPageOptions(
      imageProvider: NetworkImage(imageList[index]),
      initialScale: PhotoViewComputedScale.contained * 0.8,
      minScale: PhotoViewComputedScale.contained * 0.8,
      maxScale: PhotoViewComputedScale.covered * 2 ,
      //heroAttributes: HeroAttributes(tag: imageList[index].id),
    );
  
  },
   backgroundDecoration: BoxDecoration(color:Theme.of(context).canvasColor),
   
      ) ,),
      Positioned(
          top: 20.0,
          right: 15.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Icon(Icons.cancel, size: 30.0)),
          )),

    ]));
  }
}

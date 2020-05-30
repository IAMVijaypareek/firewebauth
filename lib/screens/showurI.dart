import 'package:firewebauth/screens/mobile_storage.dart';
import 'package:flutter/material.dart';

class ShowImg extends StatefulWidget {
  final String url;

  ShowImg({this.url});

  @override
  _ShowImgState createState() => _ShowImgState();
}

class _ShowImgState extends State<ShowImg> {
  Image m;

  Future<Widget> _getImage(BuildContext context) async {
    await FireStorageService.loadImage(context).then((downloadUrl) {
      m = Image.network(
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
    return m;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Images ")),
      body: Center(
        child: Container(
            child: Column(
          children: <Widget>[
            //Image.network(widget.url),
            Expanded(
                child: FutureBuilder(
                    future: _getImage(context),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done)
                        return Container(
                            color: Colors.white,
                            height: MediaQuery.of(context).size.height / 2,
                            width: MediaQuery.of(context).size.width / 2,
                            child: CircleAvatar(
                                backgroundColor: Colors.blue,
                                child: CircleAvatar(
                                    backgroundColor: Colors.blue,
                                    radius: 70.0,
                                    backgroundImage:// m.image
                                    snapshot.data.image,
                                    ))
                            //snapshot.data
                            );

                      if (snapshot.connectionState == ConnectionState.waiting)
                        return Container(
                            height: MediaQuery.of(context).size.height / 1.25,
                            width: MediaQuery.of(context).size.width / 1.25,
                            child: CircularProgressIndicator());

                      return Container();
                    }))
          ],
        )
            //Image.network(url);

            ),
      ),
    );
  }
}

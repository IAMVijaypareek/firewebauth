import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firewebauth/models/meraicon.dart';
import 'package:firewebauth/screens/favorites.dart';
import 'package:firewebauth/screens/namedetail.dart';
import 'package:firewebauth/screens/ordersmap.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firewebauth/screens/searchbar.dart';
import 'package:firewebauth/screens/showurI.dart';
import 'package:firewebauth/screens/webvieweg.dart';
import 'package:firewebauth/services/auth_service.dart';
import 'package:firewebauth/utils/global.dart';
import 'package:firewebauth/widgets/carouselslidereg.dart';
import 'package:firewebauth/widgets/imagespecial.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firewebauth/screens/itemdetails.dart';
import 'package:firewebauth/models/Store.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:firewebauth/provider/cartmodelprovider.dart';
import 'package:shimmer/shimmer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BuildContext context;
  int index = 0;
  File sampleImage;
  String url;

  @override
  Widget build(BuildContext context) {
    CartModel cartModel = Provider.of<CartModel>(context);
    FirebaseUser user1 = Provider.of<FirebaseUser>(context);

    var scaffold = Scaffold(
      appBar: AppBar(
          title: Shimmer.fromColors(
            baseColor: Colors.red,
            highlightColor:Colors.yellow,
            child: Text("Ecommon")),
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xff374ABE), Color(0xff64B6FF)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.horizontal()),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
                icon: Icon(Icons.favorite),
                color: Colors.white,
                onPressed: () {
                  Navigator.of(context).push(CupertinoPageRoute(
                      builder: (BuildContext context) => GirliesFavorities()));
                }),
            IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  showSearch(context: context, delegate: DataSearch());
                })
            /* Stack(alignment: Alignment.topLeft, children: <Widget>[  
              IconButton(
                  icon: Icon(Icons.chat),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.of(context).push(CupertinoPageRoute(
                        builder: (BuildContext context) =>
                            GirliesFavorities()));
                  }),
              CircleAvatar(
                  radius: 8.0,
                  backgroundColor: Colors.red,
                  child: new Text("0",
                      style: TextStyle(color: Colors.white, fontSize: 12.0)))
            ]) */
          ]),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                color: Colors.white,
                //height: ((MediaQuery.of(context).size.height)) * 2,
                width: MediaQuery.of(context).size.width,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(0.0),
                      child: Container(child: CarouselDemo()),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        height: 200,

                        // decoration: BoxDecoration(),
                        // duration: Duration(seconds: 2),
                        //curve: Curves.elasticInOut,
                        child: Material(
                          //color: Colors.grey[200],
                          child: InkWell(
                              hoverColor: Colors.red,

                              //highlightColor: Colors.blue[200],
                              //splashColor: Colors.green,
                              onTap: () {
                                var width = MediaQuery.of(context).size.width;
                                var height =
                                    ((MediaQuery.of(context).size.height));
                                print("height $height");
                                print(width);
                                //Color(0xff374ABE);
                              },
                              child: StreamBuilder<Object>(
                                  stream: Firestore.instance
                                      .collection("carddata1")
                                      .document("uid")
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    DocumentSnapshot ds1 = snapshot.data;
                                    if (!snapshot.hasData)
                                      return Text("loading");
                                    return Cardwala(
                                        text1: ds1["text1"],
                                        text2: ds1["text2"],
                                        text3: ds1["text3"],
                                        color1: 0xFFE0F7FA,
                                        color2: 0xFFB2EBF2,
                                        color3: 0xFF80DEEA);
                                  })
                              /*Cardwala(
                                text1: "Jai Shri ram",
                                text2: "Siya Ram",
                                text3: "sabke ram",
                                color1: 0xFFE0F7FA,
                                color2: 0xFFB2EBF2,
                                color3: 0xFF80DEEA,
                              ) */
                              ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    /* StreamBuilder(
          stream: Firestore.instance.collection('users').snapshots() ,
          //initialData: initialData ,
          builder: (context,snapshot){
           if(!snapshot.hasData) return Text(' loading plz wait..');
           return Column(
             children:<Widget>[
           Text(snapshot.data.documents[0]['firstName']),
            Text(snapshot.data.documents[0]['lastName']),
             ]
           );
          },
                ), */
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        height: 150,

                        //Flexible kr le aur container hata de
                        child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1),
                            itemCount: storeItems.length,
                            itemBuilder: (BuildContext context, int index) {
                              //print("This is GridView Buider $index");
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ItemDetail(
                                            itemImage:
                                                storeItems[index].itemImage,
                                            itemName:
                                                storeItems[index].itemName,
                                            itemPrice:
                                                storeItems[index].itemPrice,
                                            itemRating:
                                                storeItems[index].itemRating,
                                            indexx: index,
                                          )));
                                  print("print Navigator");
                                },
                                child: Card(
                                    elevation: 3.0,
                                    shadowColor: Colors.pink,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.white70, width: 0),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    margin: EdgeInsets.all(8.0),
                                    child: Stack(
                                        alignment: FractionalOffset.topLeft,
                                        children: <Widget>[
                                          Stack(
                                            alignment:
                                                FractionalOffset.bottomCenter,
                                            children: <Widget>[
                                              Container(
                                                decoration: new BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    image: new DecorationImage(
                                                        fit: BoxFit.fitHeight,
                                                        image: new NetworkImage(
                                                            storeItems[index]
                                                                .itemImage))),
                                              ),
                                              Container(
                                                height: 35.0,
                                                decoration: new BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: Colors.black
                                                        .withAlpha(100)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Text(
                                                        "${storeItems[index].itemName.substring(0, 6)}...",
                                                        style: new TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 16.0,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      Text(
                                                        "${storeItems[index].itemPrice}",
                                                        style: new TextStyle(
                                                            color:
                                                                Colors.red[500],
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Container(
                                                  height: 30.0,
                                                  width: 60.0,
                                                  decoration: new BoxDecoration(
                                                      color: Colors.black,
                                                      borderRadius:
                                                          new BorderRadius.only(
                                                        topRight:
                                                            new Radius.circular(
                                                                5.0),
                                                        bottomRight:
                                                            new Radius.circular(
                                                                5.0),
                                                      )),
                                                  child: new Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: <Widget>[
                                                      new Icon(
                                                        Icons.star,
                                                        color: Colors.blue,
                                                        size: 20.0,
                                                      ),
                                                      new Text(
                                                        "${storeItems[index].itemRating}",
                                                        style: new TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                IconButton(
                                                    icon: Icon(
                                                      Icons.favorite_border,
                                                      color: Colors.blue,
                                                    ),
                                                    onPressed: () {}),
                                              ],
                                            ),
                                          )
                                        ])),
                              );
                            }),

                        //container band h niche
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        height: 200,

                        // decoration: BoxDecoration(),

                        child: Material(
                          //color: Colors.grey[200],
                          child: InkWell(
                              hoverColor: Colors.red,

                              //highlightColor: Colors.blue[200],
                              //splashColor: Colors.green,
                              onTap: () {
                                var width = MediaQuery.of(context).size.width;
                                var height =
                                    ((MediaQuery.of(context).size.height));
                                print("height $height");
                                print(width);
                                //Color(0xff374ABE);
                              },
                              child: StreamBuilder<Object>(
                                  stream: Firestore.instance
                                      .collection("carddata2")
                                      .document("uid")
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    DocumentSnapshot ds1 = snapshot.data;
                                    if (!snapshot.hasData)
                                      return Text("loading");
                                    return Cardwala(
                                        text1: ds1["text1"],
                                        text2: ds1["text2"],
                                        text3: ds1["text3"],
                                        color1: 0xFF4DD0E1,
                                        color2: 0xFF26C6DA,
                                        color3: 0xFF00ACC1);
                                  })),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        alignment: Alignment.topLeft,
                        height: 200,
                        // width: 300,

                        // color:Colors.blue,

                        //Flexible kr le aur container hata de
                        child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemCount: storeItems.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ItemDetail(
                                            itemImage:
                                                storeItems[index].itemImage,
                                            itemName:
                                                storeItems[index].itemName,
                                            itemPrice:
                                                storeItems[index].itemPrice,
                                            itemRating:
                                                storeItems[index].itemRating,
                                            indexx: index,
                                          )));
                                },
                                child: Card(
                                    elevation: 3.0,
                                    shadowColor: Colors.pink,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.white70, width: 0),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    margin: EdgeInsets.all(8.0),
                                    child: Stack(
                                        alignment: FractionalOffset.topLeft,
                                        children: <Widget>[
                                          Stack(
                                            alignment:
                                                FractionalOffset.bottomCenter,
                                            children: <Widget>[
                                              Container(
                                                ///child: IconButton(icon: Icon(Icons.access_alarms),
                                                // iconSize: 30.0,
                                                //onPressed: (){}),
                                                decoration: new BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    image: new DecorationImage(
                                                        fit: BoxFit.fitWidth,
                                                        image: new AssetImage(
                                                            storeItemss[index]
                                                                .itemImage))),
                                              ),
                                              Container(
                                                height: 35.0,
                                                decoration: new BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  //  color: Colors.black
                                                  //    .withAlpha(100)
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      /* Text(
                                                        "${storeItems[index].itemName.substring(0, 6)}...",
                                                        style: new TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700,
                                                            fontSize: 16.0,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      Text(
                                                        "${storeItems[index].itemPrice}",
                                                        style: new TextStyle(
                                                            color: Colors
                                                                .red[500],
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),*/
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Container(
                                                  height: 30.0,
                                                  width: 60.0,
                                                  /* decoration:
                                                      new BoxDecoration(
                                                          color: Colors.black,
                                                          borderRadius:
                                                              new BorderRadius
                                                                  .only(
                                                            topRight: new Radius
                                                                    .circular(
                                                                5.0),
                                                            bottomRight:
                                                                new Radius
                                                                        .circular(
                                                                    5.0),
                                                          )
                                                          ),*/
                                                  child: new Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: <Widget>[
                                                      /*Icon(
                                                        Icons.star,
                                                        color: Colors.blue,
                                                        size: 20.0,
                                                      ),*/
                                                      /* Text(
                                                        "${storeItems[index].itemRating}",
                                                        style: new TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )*/
                                                    ],
                                                  ),
                                                ),
                                                /* IconButton(
                                                    //icon: Icon(
                                                      //Icons.hearing
                                                      //color: Colors.blue,
                                                    ),
                                                    onPressed: () {}),*/
                                              ],
                                            ),
                                          )
                                        ])),
                              );
                            }),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        height: 200,
                        child: Material(
                          //color: Colors.grey[200],
                          child: InkWell(
                              hoverColor: Colors.red,

                              //highlightColor: Colors.blue[200],
                              //splashColor: Colors.green,
                              onTap: () {
                                var width = MediaQuery.of(context).size.width;
                                var height =
                                    ((MediaQuery.of(context).size.height));
                                print("height $height");
                                print(width);
                                //Color(0xff374ABE);
                              },
                              child: StreamBuilder<Object>(
                                  stream: Firestore.instance
                                      .collection("carddata3")
                                      .document("uid")
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    DocumentSnapshot ds1 = snapshot.data;
                                    if (!snapshot.hasData)
                                      return Text("loading");
                                    return Cardwala(
                                        text1: ds1["text1"],
                                        text2: ds1["text2"],
                                        text3: ds1["text3"],
                                        color1: 0xFFEDE7F6,
                                        color2: 0xFFD1C4E9,
                                        color3: 0xFFB39DDB);
                                  })
                              /* Cardwala(
                                text1: "Jai",
                                text2: "Mata",
                                text3: "Di",
                                color1: 0xFFEDE7F6,
                                color2: 0xFFD1C4E9,
                                color3: 0xFFB39DDB,
                              ) */
                              ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        height: 350,
                        // width: 300,

                        //Flexible kr le aur container hata de
                        child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2),
                            itemCount: storeItems.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ItemDetail(
                                            itemImage:
                                                storeItems[index].itemImage,
                                            itemName:
                                                storeItems[index].itemName,
                                            itemPrice:
                                                storeItems[index].itemPrice,
                                            itemRating:
                                                storeItems[index].itemRating,
                                            indexx: index,
                                          )));
                                },
                                child: Card(
                                    elevation: 3.0,
                                    shadowColor: Colors.pink,
                                    shape: RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.white70, width: 0),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    margin: EdgeInsets.all(8.0),
                                    child: Stack(
                                        alignment: FractionalOffset.topLeft,
                                        children: <Widget>[
                                          Stack(
                                            alignment:
                                                FractionalOffset.bottomCenter,
                                            children: <Widget>[
                                              Container(
                                                decoration: new BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    image: new DecorationImage(
                                                        fit: BoxFit.fitHeight,
                                                        image: new NetworkImage(
                                                            storeItems[index]
                                                                .itemImage))),
                                              ),
                                              Container(
                                                height: 35.0,
                                                decoration: new BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: Colors.black
                                                        .withAlpha(100)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Text(
                                                        "${storeItems[index].itemName.substring(0, 6)}...",
                                                        style: new TextStyle(
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize: 16.0,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      Text(
                                                        "${storeItems[index].itemPrice}",
                                                        style: new TextStyle(
                                                            color:
                                                                Colors.red[500],
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(2.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                Container(
                                                  height: 30.0,
                                                  width: 60.0,
                                                  decoration: new BoxDecoration(
                                                      color: Colors.black,
                                                      borderRadius:
                                                          new BorderRadius.only(
                                                        topRight:
                                                            new Radius.circular(
                                                                5.0),
                                                        bottomRight:
                                                            new Radius.circular(
                                                                5.0),
                                                      )),
                                                  child: new Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: <Widget>[
                                                      new Icon(
                                                        Icons.star,
                                                        color: Colors.blue,
                                                        size: 20.0,
                                                      ),
                                                      new Text(
                                                        "${storeItems[index].itemRating}",
                                                        style: new TextStyle(
                                                            color:
                                                                Colors.white),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                IconButton(
                                                    icon: Icon(
                                                      Icons.favorite_border,
                                                      color: Colors.blue,
                                                    ),
                                                    onPressed: () {}),
                                              ],
                                            ),
                                          )
                                        ])),
                              );
                            }),
                      ),
                    ),
                    //Container(child: SvgPicture.network('lib\myfonts\shirt.svg')),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Container(
                        height: 200,
                        //width: 300,

                        // decoration: BoxDecoration(),

                        child: Material(
                          //color: Colors.grey[200],
                          child: InkWell(
                              hoverColor: Colors.red,

                              //highlightColor: Colors.blue[200],
                              //splashColor: Colors.green,
                              onTap: () {
                                var width = MediaQuery.of(context).size.width;
                                var height =
                                    ((MediaQuery.of(context).size.height));
                                print("height $height");
                                print(width);
                                //Color(0xff374ABE);
                              },
                              child: StreamBuilder<Object>(
                                  stream: Firestore.instance
                                      .collection("carddata4")
                                      .document("uid")
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    DocumentSnapshot ds1 = snapshot.data;
                                    if (!snapshot.hasData)
                                      return Text("loading");
                                    return Cardwala(
                                        text1: ds1["text1"],
                                        text2: ds1["text2"],
                                        text3: ds1["text3"],
                                        color1: 0xFF5E35B1,
                                        color2: 0xFF512DA8,
                                        color3: 0xFF4527A0);
                                  })
                              /*Cardwala(
                                text1: "Jai",
                                text2: "Siya",
                                text3: "Ram",
                                color1: 0xFF5E35B1,
                                color2: 0xFF512DA8,
                                color3: 0xFF4527A0,
                              )*/
                              ),
                        ),
                      ),
                    ),
                    /* Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          height: 100,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              AnimatedBuilder(
                                animation: _animation1,
                                builder: (BuildContext context, Widget child) {
                                  String frame =
                                      _animation1.value.toString().padLeft(3, '0');

                                  return //Text("$frame");
                                      Image.asset(
                                    "images/assets/frame_${frame}_delay-0.04s.png",
                                    gaplessPlayback: true,
                                  );
                                },
                              ),
                              //Text('Image: Guillaume Kurkdjian',
                              // style: new TextStyle(fontStyle: FontStyle.italic)),
                            ],
                          )),
                    )*/

                    //Flexible(child: Cardwala()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: new Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          new FloatingActionButton(
            // backgroundColor: darkblue,
            //splashColor: Colors.pink,
            //hoverColor: Colors.pink,
            onPressed: () {
              Navigator.of(context).push(new CupertinoPageRoute(
                  builder: (BuildContext context) => WebViewExample()));
            },
            child: new Icon(Icons.shopping_cart),
          ),
          new CircleAvatar(
            radius: 10.0,
            backgroundColor: Colors.red,
            child: new Text(
              cartModel.selectedProducts.length.toString(),
              style: new TextStyle(color: Colors.white, fontSize: 12.0),
            ),
          )
        ],
      ),
      /*bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          new BottomNavigationBarItem(
            activeIcon: Icon(Icons.home),
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.mail),
            title: Text('Messages'),
          ),
          new BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('Profile'))
        ],
      ), */

      bottomNavigationBar: BottomNavigationBar(

          //elevation: 100.0,
          currentIndex: 0,

          //fixedColor: Colors.brown,
          backgroundColor: Colors.white,
          //type: BottomNavigationBarType.fixed,
          // onTap:onTappedBar;
          onTap: (int index) {
            setState(() {
              this.index = index;
              print(index);
              if (index == 0) {
                Navigator.of(context).push(new CupertinoPageRoute(
                    builder: (BuildContext context) => new HomePage()));
              }
              if (index == 1) {
                Navigator.of(context).push(new CupertinoPageRoute(
                    builder: (BuildContext context) => UploadImageeg()));
              }
              if (index == 2) {
                Navigator.of(context).push(new CupertinoPageRoute(
                    builder: (BuildContext context) => ShowImg()));
              }
            });
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              title: Text("Home"),
              icon: Icon(Icons.home),
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text("Profile Setting"),
            ),
            BottomNavigationBarItem(
              title: Text("Favorites"),
              icon: Icon(Icons.favorite),
            ),
          ]),
      drawer: Drawer(
          child: SingleChildScrollView(
        child: Container(
          child: Center(
            child: Column(children: <Widget>[
              StreamBuilder(
                /* stream: Firestore.instance
                    .collection('userData')
                    .document(user1.uid)
                    .collection('Customer Coll')
                    .document('Cust Doc')
                    .snapshots(),*/
                stream: FirebaseAuth.instance.onAuthStateChanged,
                builder: (context, snapshot) {
                  return StreamBuilder<Object>(
                      stream: Firestore.instance
                          .collection('userData')
                          .document(user1.uid)
                          .collection('Customer Coll')
                          .document('Cust Doc')
                          .snapshots(),
                      builder: (context, snapshot) {
                        print("build 2");
                        DocumentSnapshot ds = snapshot.data;
                        if (!snapshot.hasData) return Text("loading");
                        return Center(
                            child: SizedBox(
                          height: 150.0,
                          child: UserAccountsDrawerHeader(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xff374ABE),
                                    Color(0xff64B6FF)
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.horizontal()),
                            accountName: Text(
                              ds['firstName'] ?? 'default',
                              style: whiteItallictTitleStyle,
                            ),
                            accountEmail: user1.phoneNumber != null
                                ? Text(user1.phoneNumber)
                                : "waiting.",
                            /*  currentAccountPicture: CircleAvatar(
                           backgroundColor: Colors.white,
                              child: GestureDetector(onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new UploadImageeg()));
                              }),
                          ),*/
                            otherAccountsPictures: <Widget>[
                              FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        new CupertinoPageRoute(
                                            builder: (BuildContext context) =>
                                                new Namedetail()));
                                  },
                                  child: Icon(Icons.edit))
                            ],
                          ),
                        ));
                      });
                  /*StreamBuilder(

                            stream: Firestore.instance
                                .collection('userData')
                                .document(useruid.getUserUID)
                                .collection('Customer Coll')
                                .snapshots(), 
                            //stream: getUsersTripsStreamSnapshots(context),
                            builder: (context, snapshot)  {
                               DocumentSnapshot ds =
                                        snapshot.data.documents[0];
                              //  DocumentSnapshot ds =
                                //         snapshot.data;
                                         
                                        //print(ds.documentID);  
                              print("build 2");
                              //if (!snapshot.hasData)
                                //return const Text("Loading...");
                              return UserAccountsDrawerHeader(
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xff374ABE),
                                              Color(0xff64B6FF)
                                            ],
                                            begin: Alignmcent.centerLeft,
                                            end: Alignment.centerRight,
                                          ),
                                          borderRadius: BorderRadius.horizontal()),
                                      accountName: Text(
                                        ds['firstName'] ?? 'defalt',
                                        style: whiteItallictTitleStyle,
                                      ),
                                      accountEmail: Text(""),
                                      currentAccountPicture: new CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: new Icon(Icons.person),
                                      ),
                                      otherAccountsPictures: <Widget>[
                                        FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  new CupertinoPageRoute(
                                                      builder:
                                                          (BuildContext context) =>
                                                              new Namedetail()));
                                            },
                                            child: Icon(Icons.edit))
                                      ],
                                    );
                              
                               /*ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.documents.length,
                                  padding: const EdgeInsets.only(top: 5.0),
                                  itemBuilder: (context, int index) {
                                    DocumentSnapshot ds =
                                        snapshot.data.documents[index];
                                    return UserAccountsDrawerHeader(
                                      decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xff374ABE),
                                              Color(0xff64B6FF)
                                            ],
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                          ),
                                          borderRadius: BorderRadius.horizontal()),
                                      accountName: Text(
                                        ds["firstName"] ?? 'defalt',
                                        style: whiteItallictTitleStyle,
                                      ),
                                      accountEmail: Text(""),
                                      currentAccountPicture: new CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: new Icon(Icons.person),
                                      ),
                                      otherAccountsPictures: <Widget>[
                                        FlatButton(
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                  new CupertinoPageRoute(
                                                      builder:
                                                          (BuildContext context) =>
                                                              new Namedetail()));
                                            },
                                            child: Icon(Icons.edit))
                                      ],
                                    );
                                  }
                                  ); */
                            
                            
                            }
                            ),*/
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(
                    Icons.notifications,
                    color: Colors.white,
                    size: 20.0,
                  ),
                ),
                title: new Text("Order Notifications"),
                onTap: () {
                  Navigator.of(context).push(new CupertinoPageRoute(
                      builder: (BuildContext context) => new Forests()));
                },
              ),
              ListTile(
                leading: CircleAvatar(
                  child: Icon(
                    Icons.history,
                    color: Colors.white,
                    size: 20.0,
                  ),
                ),
                title: new Text("Order History"),
                onTap: () {
                  Navigator.of(context).push(new CupertinoPageRoute(
                      builder: (BuildContext context) => new Forests()));
                },
              ),
              Divider(),
              /*Expanded(
                child: ListTile(
                  leading: CircleAvatar(
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 20.0,
                    ),
                  ),
                  title: new Text("Profile Settings"),
                  onTap: () {
                    Navigator.of(context).push(new CupertinoPageRoute(
                        builder: (BuildContext context) => new Namedetail()));
                  },
                ),
              ),*/
              ListTile(
                leading: CircleAvatar(
                  child: Icon(
                    Icons.home,
                    color: Colors.white,
                    size: 20.0,
                  ),
                ),
                title: new Text("Delivery Address"),
                onTap: () {
                  Navigator.of(context).push(new CupertinoPageRoute(
                      builder: (BuildContext context) => new Namedetail()));
                },
              ),
              Divider(),
              ListTile(
                trailing: CircleAvatar(
                  child: Icon(
                    Icons.help,
                    color: Colors.white,
                    size: 20.0,
                  ),
                ),
                title: new Text("About Us"),
                onTap: () {
                  Navigator.of(context).push(new CupertinoPageRoute(
                      builder: (BuildContext context) => UploadImageeg()));
                },
              ),
              ListTile(
                trailing: CircleAvatar(
                  child: Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                    size: 20.0,
                  ),
                ),
                title: new Text("Logout"),
                onTap: () {
                  /*Navigator.of(context).push(new CupertinoPageRoute(
                            builder: (BuildContext context) =>
                                new GirliesFavorities()));*/
                  AuthService().signOut();
                },
              ),
            ]),
          ),
        ),
      )),
    );
    return scaffold;
  }

  /* void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  } */
  //phele yaha QuerySnapshot tha jisme document(''Cust Doc') ni tha
  Stream<DocumentSnapshot> getUsersTripsStreamSnapshots(
      BuildContext context) async* {
    print("ye getusertrips wala h");
    //final uid = await Provider.of(context).auth.getCurrentUID();
    final uid = (await FirebaseAuth.instance.currentUser()).uid;
    yield* Firestore.instance
        .collection('userData')
        .document(uid)
        .collection('Customer Coll')
        .document('Cust Doc')
        .snapshots();
  }
}

class Cardwala extends StatefulWidget {
  const Cardwala(
      {Key key,
      this.text1,
      this.text2,
      this.text3,
      this.color1,
      this.color2,
      this.color3})
      : super(key: key);

  final String text1, text2, text3;
  final int color1, color2, color3;
  @override
  _CardwalaState createState() => _CardwalaState();
}

class _CardwalaState extends State<Cardwala>
    with SingleTickerProviderStateMixin {
  AnimationController _controller1;
  Animation<int> _animation;

  @override
  void initState() {
    _controller1 =
        AnimationController(vsync: this, duration: const Duration(seconds: 5))
          ..repeat();
    _animation = IntTween(begin: 1, end: 6).animate(_controller1);
    // _controller1.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller1.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isSelected = true;
    return Card(
        // color: Colors.blue[600],

        //color: Colors.blue,
        elevation: 0.0,
        shadowColor: Colors.pink,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: Colors.white70, width: 1),
        ),
        margin: EdgeInsets.all(8.0),
        child: Container(
            height: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(widget.color1),
                    Color(widget.color2),
                    Color(widget.color3)
                    /*  Color(4292932337),
                    Color(4280150454),
                    Color(4278239141)*/
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: SizedBox(
                      width: 20.0,
                      child: isSelected
                          ? ColorizeAnimatedTextKit(
                              totalRepeatCount: 10.0,
                              onTap: () {
                                print("Tap Event");
                              },
                              text: [widget.text1, widget.text2, widget.text3],
                              textStyle: TextStyle(
                                  fontSize: 30.0, fontFamily: "Horizon"),
                              colors: [
                                Colors.purple,
                                Colors.blue,
                                Colors.yellow,
                                Colors.red,
                              ],
                              textAlign: TextAlign.start,
                              alignment: AlignmentDirectional
                                  .topStart // or Alignment.topLeft
                              )
                          : Text("Jai Mata Di")),

                  /* Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      SizedBox(width: 20.0, height: 100.0),
                      Text(
                        "Be",
                        style: TextStyle(fontSize: 43.0),
                      ),
                      SizedBox(width: 10.0, height: 100.0),
                      Expanded(
                                              child: RotateAnimatedTextKit(
                                                totalRepeatCount: 5,
                            onTap: () {
                              print("Tap Event");
                            },
                            text: ["AWESOME", "OPTIMISTIC", "DIFFERENT"],
                            textStyle:
                                TextStyle(fontSize: 20.0, fontFamily: "Horizon"),
                            textAlign: TextAlign.start,
                            alignment: AlignmentDirectional
                                .topStart // or Alignment.topLeft
                            ),
                      ),
                    ],
                  ),*/

                  /*TypewriterAnimatedTextKit(
                      //duration: Duration(milliseconds: 2000),
                      totalRepeatCount: 4,
                      pause: Duration(milliseconds: 1000),
                      text: ["do IT!", "do it RIGHT!!", "do it RIGHT NOW!!!"],
                      textStyle: TextStyle(
                          fontSize: 32.0, fontWeight: FontWeight.bold),
                      //pause: Duration(milliseconds: 1000),
                      displayFullTextOnTap: true,
                      stopPauseOnTap: true), */

                  /*Text(
                    'Stay Home Save Lives',
                    style: TextStyle(
                        fontSize: 18,
                        color: darkblue,
                        fontWeight: FontWeight.w700),
                  ),*/
                  leading: Container(
                      //height:120,
                      width: 60,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          AnimatedBuilder(
                            animation: _animation,
                            builder: (BuildContext context, Widget child) {
                              String frame =
                                  _animation.value.toString().padLeft(3,'0');

                              return SizedBox(
                                  //Text("$frame");
                                  width: 50,
                                  child: /*Image.network(
                                    "http://designexamguide.co.in/wp-content/uploads/2017/01/img$frame.png",
                                    gaplessPlayback: true,
                                    fit: BoxFit.cover
                                    ),*/
                                  Image.asset(
                                    "images/assets/frame_${frame}_delay-0.04s.png",
                                    gaplessPlayback: true,
                                  ) 
                                  );
                            },
                          ),
                          //Text('Image: Guillaume Kurkdjian',
                          //  style: new TextStyle(fontStyle: FontStyle.italic)),
                        ],
                      )),

                  /* Image(
                    image: AssetImage("images/shirt.png"),
                  ),*/
                  trailing: Icon(Icons.lock),
                ),
              ],
            )));
  }
}

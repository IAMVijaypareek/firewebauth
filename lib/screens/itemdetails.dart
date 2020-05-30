
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firewebauth/models/Store.dart';
import 'package:firewebauth/screens/detalimage.dart';
import 'package:firewebauth/screens/productadds.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firewebauth/screens/razorpayordermap.dart';
import 'package:provider/provider.dart';
import 'package:firewebauth/provider/cartmodelprovider.dart';

class ItemDetail extends StatefulWidget {
  final String itemName;
  final String itemImage;
  final String itemSubName;
  final double itemPrice;
  final double itemRating;
  final int indexx;

  ItemDetail(
      {this.itemName,
      this.itemImage,
      this.itemRating,
      this.itemPrice,
      this.itemSubName,
      this.indexx});
  @override
  _ItemDetailState createState() => _ItemDetailState();
}

class _ItemDetailState extends State<ItemDetail> {
  String newvalue;
  var sumvalue = 0.0;
  @override
  Widget build(BuildContext context) {
    CartModel cartModel = Provider.of<CartModel>(context);

    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: new AppBar(
        title: new Text("Item Detail"),
        centerTitle: false,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body:
        /*ssssContainer(
          height: MediaQuery.of(context).size.height / 3,
          decoration: new BoxDecoration(
              color: Colors.grey.withAlpha(50), 
              borderRadius: new BorderRadius.only(
                bottomRight: new Radius.circular(120.0),
                bottomLeft: new Radius.circular(120.0),
                // topLeft: Radius.circular(120)
              )),
        ),*/
        SingleChildScrollView(
          child: Column(
            children: <Widget>[
              GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            print("clicked here");
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => DeailImageScreen(imgurls: widget.itemImage,)));
          },
          child: Hero(
            tag: 'imageHero',
            child: CachedNetworkImage(
              imageUrl:
                  widget.itemImage,
              placeholder: (context, url) => new CircularProgressIndicator(),
              errorWidget: (context, url, error) => new Icon(Icons.error),
            )),
           /*Container(
            padding: EdgeInsets.only(top:10,left:10.0,right:10.0),
           
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/2,
            decoration: BoxDecoration( color: Colors.green,
              image:DecorationImage(image: NetworkImage(widget.itemImage),fit: BoxFit.cover)
             
            ),

           
             //child:PhotoView(imageProvider: NetworkImage(widget.itemImage))
            /*Image.network(
              widget.itemImage,
              fit: BoxFit.cover,
            ),*/
          ),*/
          
        ),
              SizedBox(
                height: 10.0,
              ),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(52.0),
                      topRight: Radius.circular(52.0)),
                  //side: BorderSide()
                ),
                child: new Container(
                  width: screenSize.width,
                  margin: new EdgeInsets.only(left: 20.0, right: 20.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new SizedBox(
                        height: 10.0,
                      ),
                      new Text(
                        widget.itemName,
                        style: new TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w700),
                      ),
                      new SizedBox(
                        height: 10.0,
                      ),
                      new Text(
                        "Item Sub name",
                        style: new TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.w400),
                      ),
                      new SizedBox(
                        height: 10.0,
                      ),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              new Icon(
                                Icons.star,
                                color: Colors.blue,
                                size: 20.0,
                              ),
                              new SizedBox(
                                width: 5.0,
                              ),
                              new Text(
                                "${widget.itemRating}",
                                style: new TextStyle(color: Colors.black),
                              )
                            ],
                          ),
                          new Text(
                            "${widget.itemPrice}",
                            style: new TextStyle(
                                fontSize: 20.0,
                                color: Colors.red[500],
                                fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                      new SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: new Container(
                  width: screenSize.width,
                  height: 150.0,
                  child: new ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return new Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            new Container(
                              margin:
                                  new EdgeInsets.only(left: 5.0, right: 5.0),
                              height: 140.0,
                              width: 100.0,
                              child: new Image.network(widget.itemImage),
                            ),
                            new Container(
                              margin:
                                  new EdgeInsets.only(left: 5.0, right: 5.0),
                              height: 140.0,
                              width: 100.0,
                              decoration: new BoxDecoration(
                                  color: Colors.grey.withAlpha(50)),
                            ),
                          ],
                        );
                      }),
                ),
              ),
              Card(
                child: new Container(
                  width: screenSize.width,
                  margin: new EdgeInsets.only(left: 20.0, right: 20.0),
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new SizedBox(
                        height: 10.0,
                      ),
                      new Text(
                        "Description",
                        style: new TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w700),
                      ),
                      new SizedBox(
                        height: 10.0,
                      ),
                      new Text(
                        "My item full ",
                        style: new TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.w400),
                      ),
                      new SizedBox(
                        height: 10.0,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Container(
                  width: screenSize.width,
                  margin: new EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new SizedBox(
                        height: 10.0,
                      ),
                      new Text(
                        "Colors",
                        style: new TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w700),
                      ),
                      new SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(
                        height: 50.0,
                        child: new ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: new ChoiceChip(
                                    label: new Text("Color ${index}"),
                                    selected: false),
                              );
                            }),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      new Text(
                        "Sizes",
                        style: new TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w700),
                      ),
                      new SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(
                        height: 50.0,
                        child: new ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: new ChoiceChip(
                                    label: new Text("Size ${index}"),
                                    selected: false),
                              );
                            }),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      new Text(
                        "Sizes",
                        style: new TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.w700),
                      ),
                      new SizedBox(
                        height: 10.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          CircleAvatar(
                            child: new Icon(Icons.remove),
                          ),
                          new Text("0"),
                          new CircleAvatar(
                            child: new Icon(Icons.add),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 50.0,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      
      //stack tha pehle 
       /*Stack(
        //gesturedetector is ot working in stack
        alignment: Alignment.topLeft, children: <Widget>[
        
      ]),*/,
      floatingActionButton: new Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          new FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(new CupertinoPageRoute(
                  builder: (BuildContext context) => ProductsAdding()));
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: new BottomAppBar(
        color: Theme.of(context).primaryColor,
        elevation: 0.0,
        shape: new CircularNotchedRectangle(),
        notchMargin: 5.0,
        child: new Container(
          height: 50.0,
          decoration: new BoxDecoration(color: Theme.of(context).primaryColor),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              new Container(
                width: (screenSize.width - 20) / 2,
                child: RaisedButton(
                  color: Colors.blueAccent,
                  onPressed: () {
                    /* Navigator.of(context).push(CupertinoPageRoute(
                        builder: (BuildContext context) =>
                            GirliesFavorities()));*/
                    print("${widget.indexx}");

                    setState(() {
                      sumvalue = sumvalue + widget.itemPrice;

                      newvalue = widget.itemName;
                      cartModel.add(Store.items(
                          indexx: widget.indexx,
                          itemImage: widget.itemImage,
                          itemName: widget.itemName,
                          itemPrice: widget.itemPrice));
                    });
                    // cartModel.add(widget.itemName);

                    //cartModel.add(newvalue);
                  },
                  child: new Text(
                    "ADD TO FAVORITES",
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              new Container(
                  width: (screenSize.width - 20) / 2,
                  child: RaisedButton(
                    color: Colors.blueAccent,
                    onPressed: () {
                      Navigator.of(context).push(CupertinoPageRoute(
                          builder: (BuildContext context) => RazorPayPayments(
                              // itemImage: storeItems[index].itemImage,
                              itemName: storeItems[widget.indexx].itemName,
                              itemPrice: storeItems[widget.indexx].itemPrice,
                              itemRating: storeItems[widget.indexx].itemRating,
                              indexx: widget.indexx)));
                    },
                    child: new Text(
                      "Order Now",
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

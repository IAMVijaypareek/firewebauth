import 'package:firewebauth/screens/razorpayordermap.dart';
import 'package:firewebauth/screens/itemdetails.dart';
import 'package:firewebauth/utils/global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firewebauth/provider/cartmodelprovider.dart';

class ProductsAdding extends StatefulWidget {
  @override
  _ProductsAddingState createState() => _ProductsAddingState();
}

class _ProductsAddingState extends State<ProductsAdding> {

   
  double sums =0;


  @override
  Widget build(BuildContext context) {
    CartModel cartModel = Provider.of<CartModel>(context);
        Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(title: Text("Products")),
      body: Column(
        children: <Widget>[
          //  Padding(padding: EdgeInsets.all(8.0)),
          Expanded(
              child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: cartModel.selectedProducts.length,
                  itemBuilder: (context, int index) {
                    sums = sums + cartModel.selectedProducts[index].itemPrice;
                  
                   
                    
                    
                    return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          // height:MediaQuery.of(context).size.height/4,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: <Widget>[
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ItemDetail(
                                            itemImage: cartModel
                                                .selectedProducts[index]
                                                .itemImage,
                                            itemName: cartModel
                                                .selectedProducts[index]
                                                .itemName,
                                            itemPrice: cartModel
                                                .selectedProducts[index]
                                                .itemPrice,
                                            indexx: index,
                                          )));

                                  print("object");
                                },
                                child: Card(
                                    child: Column(children: <Widget>[
                                  new Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      new Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                3,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                4,
                                        child: Image.network(
                                          "${cartModel.selectedProducts[index].itemImage}",
                                          //height: MediaQuery.of(context).size.height/5,
                                          //width:MediaQuery.of(context).size.width/3 ,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20.0,
                                      ),
                                      new Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          //mainAxisAlignment: MainAxisAlignment.start,
                                          children: <Widget>[
                                            Text(
                                                cartModel
                                                    .selectedProducts[index]
                                                    .itemName,
                                                style: productTitleStyle),
                                            Text(cartModel
                                                .selectedProducts[index]
                                                .itemPrice
                                                .toString()),
                                            FlatButton(
                                                onPressed: () {
                                                  Provider.of<CartModel>(
                                                          context,
                                                          listen: false)
                                                      .remove(index);
                                                },
                                                child: Text(
                                                  "Remove",
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontWeight:
                                                          FontWeight.w800),
                                                ))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ])
                                    /*ListTile(
        title: Text(cartModel.selectedProducts[index].itemName,style:productTitleStyle,),
        subtitle: Text(cartModel.selectedProducts[index].itemPrice
      .toString()),
        
        leading: Container(
        color:Colors.black,
       // height:150,
      
        child: CircleAvatar(
      backgroundImage:NetworkImage("${cartModel.selectedProducts[index].itemImage}",
      ),radius: 55.0,
        ),
        
        ),
      )*/
                                    ),
                              ),
                            ],
                          ),
                        ));
                  },
                  separatorBuilder: (BuildContext context, int index) {
                   
                   
                   // Text(sum.toString());
                    return Divider();
                  })),
        ],
      ),
      floatingActionButton: new Stack(
        alignment: Alignment.topLeft,
        children: <Widget>[
          new FloatingActionButton(
            onPressed: () {
              Navigator.of(context).push(new CupertinoPageRoute(
                  builder: (BuildContext context) => RazorPayPayments(
                    itemPrice: cartModel.myvalue
                  )));
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
                     Navigator.of(context).push(new CupertinoPageRoute(
                  builder: (BuildContext context) => RazorPayPayments(
                    itemPrice: cartModel.myvalue
                  )));
                    print(sums);
                    /* Navigator.of(context).push(CupertinoPageRoute(
                        builder: (BuildContext context) =>
                            GirliesFavorities()));*/
                    /*print("${widget.indexx}");

                    setState(() {
                      newvalue = widget.itemName;
                      cartModel.add(Store.items(
                          indexx: widget.indexx,
                          itemImage: widget.itemImage,
                          itemName: widget.itemName,
                          itemPrice: widget.itemPrice));
                    });
                    // cartModel.add(widget.itemName);

                    print(newvalue); */
                    //cartModel.add(newvalue);
                  },
                  child: new Text(
                    "Total sum",
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
                       Navigator.of(context).push(new CupertinoPageRoute(
                  builder: (BuildContext context) => RazorPayPayments(
                    itemPrice: cartModel.myvalue
                  )));
                      setState(() {
                        sums =0;
                        
                      });
                      /* Navigator.of(context).push(CupertinoPageRoute(
                          builder: (BuildContext context) => RazorPayPayments(
                              // itemImage: storeItems[index].itemImage,
                              itemName: storeItems[widget.indexx].itemName,
                              itemPrice: storeItems[widget.indexx].itemPrice,
                              itemRating: storeItems[widget.indexx].itemRating,
                              indexx: widget.indexx))); */
                    },
                    child: new Text(
                      cartModel.myvalue.toString(),
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  )),
            ],
          ),
        ),
      ),

      /* Consumer<CartModel>(
        builder: (context, cart, child) {
          return
        },
      ),*/
    );
  }
}

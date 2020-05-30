import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firewebauth/models/orders.dart';

class RazorPayPayments extends StatefulWidget {
  final String itemName;
  final String itemImage;
  final String itemSubName;
  final double itemPrice;
  final double itemRating;
  final int indexx;
  RazorPayPayments(
      {this.itemName,
      this.itemImage,
      this.itemRating,
      this.itemPrice,
      this.itemSubName,
      this.indexx});
  @override
  _RazorPayPaymentsState createState() => _RazorPayPaymentsState();
}

class _RazorPayPaymentsState extends State<RazorPayPayments> {
  Firestore firestore = Firestore();
  double totalAmount = 0.00;

  Razorpay _razorpay;
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void create() async {
    Orders orders;
    orders = Orders(
      orderid: "Image",
      productname: widget.itemName,
      productprice: widget.itemPrice.toString(),
      photoUrl: widget.itemImage,
      timestamp: Timestamp.now(),
    );
    var map = orders.toMap();

    try {
      // getCurrentI
      final uid = (await FirebaseAuth.instance.currentUser()).uid;
      await firestore
          .collection("Order")
          .document(uid)
          .collection('Order Colls').add(map); 

         /* .collection('Order Coll')
          .document("Order Doc")
          .setData({
        'Item Price': widget.itemPrice,
        'Item Name': widget.itemName,
        "Item Image": widget.itemImage

        // 'lastName': name,
      }); */
      //'firstName': name,
      // 'lastName': name,
      //);
      //await firestore.collection('userData').document(uid).setData({
      //'firstName': name,
      //'lastName': name,
      //}
      // );
    } catch (e) {
      print(e);
    }
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_ExHijNZAnz8Jna',
      'amount': widget.itemPrice * 100,
      //'amount': totalAmount * 100,
      'name': 'flutterdemorazorpay',
      'description': 'Test payment from Flutter app',
      'prefill': {'contact': '', 'email': ''},
      'external': {
        'wallets': ['Paytm']
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint(e);
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: 'Error ' + response.code.toString() + ' ' + response.message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: 'Payment Success ' + response.paymentId,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.black,
        fontSize: 16.0);
    create();
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: 'Wallet Name ' + response.walletName,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
// Here we take the value from the MyHomePage object that was created by
// the App.build method, and use it to set our appbar title.
        title: Text("Razorpay Payment Test"),
      ),
      body: Center(
// Center is a layout widget. It takes a single child and positions it
// in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Proceed below to purchase:',
            ),
            /* LimitedBox(
              maxWidth: 150.0,
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Please enter some Amount',
                ),
                onChanged: (value) {
                  setState(() {
                    //print(value);
                   print("${widget.itemPrice}");
                   print("${widget.itemName}");
                   //print("${widget.Store.items.index}");
                   print("${widget.indexx}");
                   
                    totalAmount = num.parse(value);
                  });
                },
              ),
            ), */
            SizedBox(height: 15.0),
            Text("Total Amount is ${widget.itemPrice}",
            ),
            SizedBox(height: 15.0),
            RaisedButton(
              color: Colors.teal,
              child: Text(
                'Make Payment',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                openCheckout();
              },
            )
          ],
        ),
      ),
// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';

class Orders {
  String orderid;
  String productname;
  String productprice;
  Timestamp timestamp;
  String photoUrl;

  Orders(
      {this.orderid,
      this.productname,
      this.productprice,
      this.photoUrl,
      this.timestamp});
  Map toMap() {
    var map = Map<String, dynamic>();
    map['orderid'] = this.orderid;
    map['productname'] = this.productname;
    map['productprice'] = this.productprice;
    map['photoUrl'] = this.photoUrl;
    map['timestamp'] = this.timestamp;
    return map;
  }

  Orders.fromMap(Map<String, dynamic> map) {
    this.orderid = map['orderid'];
    this.productname = map['productname'];
    this.productprice = map['productprice'];
    this.photoUrl = map['photoUrl'];
    this.timestamp = map['timestamp'];
  }
}

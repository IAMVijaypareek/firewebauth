import 'package:firewebauth/models/Store.dart';
import 'package:firewebauth/screens/itemdetails.dart';
import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate<String> {

   /* 
  final cities = [
    "Bhandup",
    "Mumbai",
    "Thane",
    "Bhiwandi",
    "Mulund",
    "Kalyan",
    "Ulhasnagar 2",
    "Ulhasnagar 3",
    "Ulhasnagar 5",
    "Ulhasnagar 4",
    "Ulhasnagar 1",
    "Dadar",
    "Sion",
    "Kanjurmarg"
  ];
  final recentCities = [
    "Thane",
    "Bhiwandi",
    "Mulund",
    "Kalyan",
  ];
  */
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
    //throw UnimplementedError();
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        progress: transitionAnimation,
        icon: AnimatedIcons.menu_arrow,
      ),
      onPressed: () {
        close(context, null);
      },
    );
    // throw UnimplementedError();
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: Container(
       child: Column(
         children:<Widget>[
          FlatButton(
            onPressed:() {
             
            },
           
             child: Text(query))
           ],
         
       ), 
       
      ),
    );
    //throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? storeItems
        : storeItems.where((p) => p.itemName.startsWith(query)).toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
          onTap: () {
          
            showResults(context);
              Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context) => ItemDetail(indexx: index,itemName: suggestionList[index].itemName,
              itemImage: suggestionList[index].itemImage,itemPrice: suggestionList[index].itemPrice,itemRating: suggestionList[index].itemRating,
              )));
          },
          leading: Icon(Icons.location_city),
          title: RichText(
              text: TextSpan(
           text:suggestionList[index].itemName
           .substring(0, query.length),
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            children: [
              TextSpan(
               text: suggestionList[index].itemName
               .substring(query.length),
                style: TextStyle(color: Colors.grey),
              )
            ],
          ))),
      itemCount: suggestionList.length,
    );
    // throw UnimplementedError();
  }
}

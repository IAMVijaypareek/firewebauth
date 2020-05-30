

import 'package:firewebauth/models/Store.dart';
import 'package:flutter/material.dart';

class CartModel with ChangeNotifier{
  double myvalue = 0.0;
  
  

List<Store> _selectedProducts =[];
  List<Store> get selectedProducts => _selectedProducts;

void add(Store value){

  _selectedProducts.add(value);
  myvalue = myvalue + _selectedProducts.elementAt(_selectedProducts.length-1).itemPrice; 
  print("myvalue is $myvalue"); 
  notifyListeners();

}
void remove(int index){
  myvalue = myvalue - _selectedProducts.elementAt(index).itemPrice; 
   print("myvalue is $myvalue"); 
  _selectedProducts.removeAt(index);
  
  print("myvalue is $myvalue"); 

  notifyListeners();
}

void sum(int index){
var sum =0.0;
sum = sum + _selectedProducts[index].itemPrice;
print(sum);
notifyListeners();
}

}
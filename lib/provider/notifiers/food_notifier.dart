import 'dart:collection';
import 'package:firewebauth/models/food.dart';
import 'package:flutter/widgets.dart';

class FoodNotifier with ChangeNotifier {
  List<Food> _foodList = [];

  UnmodifiableListView<Food> get foodList => UnmodifiableListView(_foodList);

  void addFood(Food food) {
    _foodList.add(food);
    notifyListeners();
  }
}
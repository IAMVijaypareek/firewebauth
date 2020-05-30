import 'package:firewebauth/provider/notifiers/food_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'list_page.dart';
import 'package:firewebauth/models/food.dart';

class HomePages extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePagesState();
  }
}

class HomePagesState extends State<HomePages> {
  String _currentName;
  String _currentColor;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    FoodNotifier foodNotifier = Provider.of<FoodNotifier>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Provider Demo")),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Food Name'),
                initialValue: null,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Name is required';
                  }

                  return null;
                },
                onSaved: (String value) {
                  _currentName = value;
                  print('Name: $value');
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Food Color'),
                initialValue: null,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Color is required';
                  }

                  return null;
                },
                onSaved: (String value) {
                  _currentColor = value;
                  print('Color: $value');
                },
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) => Column(
                    children: <Widget>[
                      Text(foodNotifier.foodList[index].name),
                      Text(foodNotifier.foodList[index].color),
                      Divider(
                        thickness: 2,
                        color: Colors.purple,
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                      ),
                    ],
                  ),
                  itemCount: foodNotifier.foodList.length,
                ),
              ),
              RaisedButton(
                child: Text(
                  'Add Food',
                  style: TextStyle(color: Colors.purple, fontSize: 16),
                ),
                onPressed: () {
                  if (!_formKey.currentState.validate()) return;

                  _formKey.currentState.save();
                  setState(() {
                    foodNotifier.addFood(Food(_currentName, _currentColor));
                  });
                },
              ),
              RaisedButton(
                child: Text(
                  'Test',
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                ),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListPage()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
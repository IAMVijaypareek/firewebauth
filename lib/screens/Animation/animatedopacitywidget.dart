import 'package:flutter/material.dart';

class Animatedopacitywid extends StatefulWidget {
  @override
  _AnimatedopacitywidState createState() => _AnimatedopacitywidState();
}

class _AnimatedopacitywidState extends State<Animatedopacitywid> {
  bool _visible = true;
  bool dekh = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: AnimatedOpacity(
            opacity: _visible ? 1.0 : 0.0,
            duration: Duration(milliseconds: 500),
            child: Material(
              child: InkWell(
                onHover: (dekh){
                  setState(() {
                     _visible = !_visible;
                     print("object");
                  });
                  
                  Text("val");
                },
                onTap: () {
                   setState(() {
            _visible = !_visible;
          });
                          
                        },
                child: Container(
                  width: 200.0,
                  height: 200.0,
                  color: Colors.green,
                ),
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Call setState. This tells Flutter to rebuild the
          // UI with the changes.
          setState(() {
            _visible = !_visible;
          });
        },
        tooltip: 'Toggle Opacity',
        child: Icon(Icons.flip),
      ),
    );
  }
}

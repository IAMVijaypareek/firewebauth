import 'package:flutter/material.dart';

class AnimatingWidgetBuilder extends StatefulWidget {
  @override
  _AnimatingWidgetBuilderState createState() => _AnimatingWidgetBuilderState();
}

class _AnimatingWidgetBuilderState extends State<AnimatingWidgetBuilder>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<int> _animation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 5))
          ..repeat();
    _animation = IntTween(begin: 1, end: 6).animate(_controller);
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AnimatedBuilder(
          animation: _animation,
          builder: (BuildContext context, Widget child) {
            String frame = _animation.value.toString().padLeft(3, '0');
            
            return //Text("$frame");
             Image.asset(
              "images/assets/frame_${frame}_delay-0.04s.png",
              gaplessPlayback: true,
           );
          },
        ),
        Text('Image: Guillaume Kurkdjian',
            style: new TextStyle(fontStyle: FontStyle.italic)),
      ],
    ));
  }
}

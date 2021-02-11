import 'package:flutter/material.dart';

class NumberAnimation extends StatefulWidget {
  final double value;
  final TextStyle customTextStyle;
  final int decimals;

  NumberAnimation({Key key, this.value, this.customTextStyle, this.decimals})
      : super(key: key);
  @override
  createState() => new _NumberAnimationState(value: value, customTextStyle: customTextStyle, decimals: decimals);
}

class _NumberAnimationState extends State<NumberAnimation>
    with TickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  final double value;
  final TextStyle customTextStyle;
  final int decimals;

  _NumberAnimationState({this.value, this.customTextStyle, this.decimals});

  @override
  initState() {
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animation = new Tween<double>(
      begin: 0.0,
      end: value,
    ).animate(
      new CurvedAnimation(
        curve: Curves.fastOutSlowIn,
        parent: _controller,
      ),
    );
    _controller.forward(from: 0.0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedBuilder(
            animation: _animation,
            builder: (BuildContext context, Widget child) {
              return Text(
                _animation.value.toStringAsFixed(decimals),
                style: customTextStyle,
              );
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

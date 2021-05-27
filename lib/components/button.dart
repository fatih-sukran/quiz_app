import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final Text text;
  final Color color;
  final Function onTap;

  Button({@required this.text, @required this.color, @required this.onTap});

  @override
  _ButtonState createState() => _ButtonState();
}

class _ButtonState extends State<Button> with SingleTickerProviderStateMixin {
  double _scale;
  AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _scale = 1 - _controller.value;
    setState(() {

    });
    return buildCenter();
  }

  Center buildCenter() {
    return Center(
      child: GestureDetector(
        onTap: _onTapFunction(),
        child: Transform.scale(
          scale: _scale,
          child: _animatedButtonUI,
        ),
      ),
    );
  }

  Widget get _animatedButtonUI => Container(
        height: 50,
        width: MediaQuery.of(context).size.width * 0.75,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100.0),
            boxShadow: [
              BoxShadow(
                color: Color(0x80000000),
                blurRadius: 30.0,
                offset: Offset(0.0, 5.0),
              ),
            ],
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                widget.color,
                widget.color,
              ],
            )),
        child: Center(
          child: widget.text,
        ),
      );

  Function _onTapFunction() => () {
        _controller.forward();
        Future.delayed(
          Duration(milliseconds: 200),
          () => _controller.reverse(),
        );
        Future.delayed(
          Duration(milliseconds: 400),
          widget.onTap,
        );
      };
}

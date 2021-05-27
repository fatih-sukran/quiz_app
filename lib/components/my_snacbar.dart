import 'package:flutter/material.dart';

enum MySnackBar {
  info,
  success,
  warning,
  error,
}

class MyAnimation extends StatefulWidget {
  final String message;
  final String title;
  final Color color;
  final IconData iconData;

  const MyAnimation(
      {Key key, this.message, this.title, this.color, this.iconData})
      : super(key: key);
  @override
  _MyAnimationState createState() => _MyAnimationState();
}

class _MyAnimationState extends State<MyAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  double _width;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      upperBound: 300,
      lowerBound: 180,
      duration: Duration(milliseconds: 800),
    )
      ..addListener(() {
        setState(() {
          _width = _animationController.value;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Future.delayed(Duration(milliseconds: 2400), () {
            _animationController.reverse();
          });
        }
      })
      ..forward();
    //final _animation = Tween<double>().animate(_animationController);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
          child: Container(
        width: _width,
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: widget.color,
        ),
        child: SizedBox(
          child: ListTile(
            leading: Container(
              child: Icon(
                widget.iconData,
                color: Colors.white,
                size: 50,
              ),
            ),
            title: widget.title != null
                ? null
                : Text(
                    widget.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Theme.of(context).textTheme.headline6.fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            subtitle: widget.message == null
                ? null
                : Text(
                    widget.message,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Theme.of(context).textTheme.subtitle2.fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

SnackBar getSnackBar({
  @required BuildContext context,
  @required MySnackBar mySnackBar,
  String title,
  String message,
}) {
  List<Color> color = [
    Color(0xff35c4fc),
    Color(0xff75d00f),
    Color(0xffffb70a),
    Color(0xfff33950),
  ];
  List<IconData> iconData = [
    Icons.info,
    Icons.check_circle,
    Icons.warning,
    Icons.error,
  ];
  return SnackBar(
    elevation: 0,
    backgroundColor: Colors.transparent,
    behavior: SnackBarBehavior.floating,
    padding: EdgeInsets.only(
      top: 34,
      left: 8,
      right: 8,
    ),
    content: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // MyAnimation(
        //   message: message,
        //   title: title,
        //   color: color[mySnackBar.index],
        //   iconData: iconData[mySnackBar.index],
        // ),
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: color[mySnackBar.index],
          ),
          child: ListTile(
            leading: Container(
              child: Icon(
                iconData[mySnackBar.index],
                color: Colors.white,
                size: 50,
              ),
            ),
            title: title == null
                ? null
                : Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Theme.of(context).textTheme.headline6.fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
            subtitle: message == null
                ? null
                : Text(
                    message,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Theme.of(context).textTheme.subtitle2.fontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ],
    ),
  );
}

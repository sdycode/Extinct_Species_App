import 'package:flutter/material.dart';

class CustomPageRouteSlider extends PageRouteBuilder {
  final Widget child;
  AxisDirection direction;
  CustomPageRouteSlider({
    required this.child,
    required this.direction,
  }) : super(
            transitionDuration: const Duration(seconds: 2),
            pageBuilder: (context, animation, secondAnimation) => child);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
        position: Tween<Offset>(begin: getOffset(), end: Offset.zero)
            .animate(animation),
        child: child);
  }

  Offset getOffset() {
    switch (direction) {
      case AxisDirection.up:
        return Offset(0, 1);
      case AxisDirection.down:
        return Offset(1, 0);
      case AxisDirection.right:
        return Offset(0, -1);
      case AxisDirection.up:
        return Offset(-1, 0);
      default:
        return Offset(-1, 0);
    }
  }
}

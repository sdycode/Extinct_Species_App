import 'package:flutter/material.dart';

class CustomPageRouteRotate extends PageRouteBuilder {
  final Widget child;
  CustomPageRouteRotate({
    required this.child,
  }) : super(
              transitionDuration: const Duration(seconds: 2),
              pageBuilder: (context, animation, secondAnimation) => child);


  
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return RotationTransition( 
    turns: animation,
    child: child);
  }


}

import 'package:flutter/material.dart';

class CustomPageRouteFade extends PageRouteBuilder {
  final Widget child;
  CustomPageRouteFade({
    required this.child,
  }) : super(
              transitionDuration: const Duration(seconds: 2),
              pageBuilder: (context, animation, secondAnimation) => child);


  
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return FadeTransition( opacity: animation,
    child: child);
  }


}

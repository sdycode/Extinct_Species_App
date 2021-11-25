import 'package:flutter/material.dart';

class CustomPageRouteScale extends PageRouteBuilder {
  final Widget child;
  CustomPageRouteScale({
    required this.child,
  }) : super(
              transitionDuration: const Duration(seconds: 2),
              pageBuilder: (context, animation, secondAnimation) => child);


  
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return ScaleTransition(scale: animation, child: child);
  }


}

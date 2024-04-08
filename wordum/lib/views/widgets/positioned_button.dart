import 'package:flutter/material.dart';

class PositionedButton extends StatelessWidget{
  final Widget child;
  final double top;
  final double bottom;
  final double left;
  final double right;

  const PositionedButton({
    required this.child,

    // Set with wrong value that will not be rendered
    this.top = double.infinity,
    this.bottom = double.infinity,
    this.left = double.infinity,
    this.right = double.infinity,

    super.key,
  });

  @override
  Widget build(BuildContext context){
    return Positioned(

      // Dont specify positioning if not set
      top: top != double.infinity ? top : null,
      bottom: bottom != double.infinity ? bottom : null,
      left: left != double.infinity ? left : null,
      right: right != double.infinity ? right : null,

      child: SizedBox(
        width: 66,
        height: 66,
        child: FittedBox(
          child: child,
        ),
      )
    );
  }
}
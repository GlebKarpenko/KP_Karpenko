import 'package:flutter/material.dart';

class RoundedTextBox extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final double borderRadius;
  final TextStyle textStyle;
  final EdgeInsets padding;

  const RoundedTextBox({
    Key? key,
    required this.title,
    this.backgroundColor = Colors.white,
    this.borderRadius = 15.0,
    this.textStyle = const TextStyle(color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold),
    this.padding = const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      padding: padding,
      child: Text(
        title,
        style: textStyle,
      ),
    );
  }
}

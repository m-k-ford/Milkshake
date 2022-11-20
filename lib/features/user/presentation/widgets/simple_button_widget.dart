import 'package:flutter/material.dart';

class SimpleButtonWidget extends StatelessWidget {
  final Color backgroundColour;
  final Color textColour;
  final String title;
  final double height;
  final double width;
  final double fontSize;

  const SimpleButtonWidget({
    Key? key,
    required this.backgroundColour,
    required this.textColour,
    required this.title,
    required this.height,
    required this.width,
    required this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: backgroundColour,
      ),
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: textColour,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}

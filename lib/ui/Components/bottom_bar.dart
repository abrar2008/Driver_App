import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:EfendimDriverApp/ui/Themes/colors.dart';
import 'package:EfendimDriverApp/ui/Themes/style.dart';

class BottomBar extends StatelessWidget {
  final Function onTap;
  final String text;
  final Color color;
  final Color textColor;

  BottomBar(
      {@required this.onTap, @required this.text, this.color, this.textColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 77,
        child: Center(
          child: Text(
            text,
            style: bottomBarTextStyle.copyWith(color: textColor) ??
                bottomBarTextStyle,
          ),
        ),
        color: color ?? kMainColor,
        height: 50.0,
      ),
    );
  }
}

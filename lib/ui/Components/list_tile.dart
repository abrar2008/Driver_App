import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BuildListTile extends StatelessWidget {
  final String image;
  final String text;
  final Function onTap;
  final bool useSVG;
  final bool useImageWidget;
  final Widget imageWidget;

  BuildListTile(
      {this.image,
      this.text,
      this.onTap,
      this.useSVG = false,
      this.useImageWidget = false,
      this.imageWidget});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 20.0),
      leading: useSVG
          ? SvgPicture.asset(
              image,
              height: 25.3,
            )
          : useImageWidget
              ? imageWidget
              : Image.asset(
                  image,
                  height: 25.3,
                ),
      title: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .headline4
            .copyWith(fontWeight: FontWeight.w500),
      ),
      onTap: onTap,
    );
  }
}

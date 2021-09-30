import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Themes/colors.dart';

class ChatHeader extends StatelessWidget {
  final String title;
  final String subtitle;
  final void Function() onOpenContact;

  ChatHeader({
    @required this.title,
    this.subtitle,
    this.onOpenContact,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: Get.textTheme.subtitle2.copyWith(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      subtitle: subtitle != null
          ? Text(
              subtitle,
              style: Get.textTheme.bodyText2.copyWith(
                fontSize: 12,
              ),
            )
          : null,
      trailing: onOpenContact != null
          ? IconButton(
              onPressed: onOpenContact,
              icon: Icon(Icons.phone),
              color: kMainColor,
            )
          : null,
    );
  }
}

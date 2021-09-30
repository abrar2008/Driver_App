import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../chats/chat_support_guest_form/chat_support_guest_form_page.dart';

class HelpText extends StatefulWidget {
  final String text;

  HelpText({
    @required this.text,
  });

  @override
  _HelpTextState createState() => _HelpTextState();
}

class _HelpTextState extends State<HelpText> with TickerProviderStateMixin {
  AnimationController slideController;
  AnimationController iconRotationController;

  Animation<double> iconSizeAnimation;

  Timer shakeTimer;

  @override
  void initState() {
    super.initState();

    slideController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    iconRotationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );

    iconSizeAnimation = CurvedAnimation(
      parent: slideController,
      curve: Interval(0.6, 1, curve: Curves.fastOutSlowIn),
    );

    slideController.forward();

    iconRotationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // shakeController.reverse();
      }
    });

    shakeTimer = Timer.periodic(Duration(seconds: 10), (timer) {
      iconRotationController.forward(from: 0);
    });
  }

  @override
  void dispose() {
    shakeTimer.cancel();
    iconRotationController.dispose();
    slideController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(4, 0),
        end: Offset(0, 0),
      ).animate(CurvedAnimation(
        parent: slideController,
        curve: Curves.elasticOut,
      )),
      child: _buildText(),
    );
  }

  // Widget _buildShakeAnimation() {
  //   return AnimatedBuilder(
  //     animation: Tween<double>(begin: 0, end: 1).animate(
  //       CurvedAnimation(parent: shakeController, curve: Curves.bounceIn),
  //     ),
  //     builder: builder,
  //   );
  // }

  Widget _buildText() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () async {
            Get.to(() => ChatSupportGuestFormPage());
          },
          child: Text(
            widget.text,
            style: TextStyle(
              color: Get.theme.primaryColor,
              decoration: TextDecoration.underline,
              fontSize: 16,
            ),
          ),
        ),
        SizedBox(width: 10),
        Container(
          height: 24,
          child: AnimatedBuilder(
            animation: iconSizeAnimation,
            builder: (context, child) {
              return RotationTransition(
                turns: Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
                  parent: iconRotationController,
                  curve: Curves.fastOutSlowIn,
                )),
                child: Icon(
                  Icons.phone,
                  color: Get.theme.primaryColor,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

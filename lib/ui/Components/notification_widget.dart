import 'dart:convert';

import 'package:base_notifier/base_notifier.dart';
import 'package:flutter/material.dart';
import 'package:EfendimDriverApp/core/api/api.dart';
import 'package:EfendimDriverApp/core/api/http_api.dart';
import 'package:EfendimDriverApp/core/auth/authentication_service.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:ui_utils/ui_utils.dart';
import 'package:EfendimDriverApp/ui/routes copy/route_new.dart';

class Notify extends StatelessWidget {
  final String title;
  final String body;
  final Map<dynamic, dynamic> data;

  Notify({Key key, this.title, this.body, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final grad = Gradients.secandaryGradient;
    final textColor = Color(0xff5C6470);

    return BaseWidget<NotifyModel>(
        model: NotifyModel(
          auth: Provider.of(context),
          api: Provider.of<Api>(context),
          context: context,
        ),
        builder: (context, model, child) {
          return SafeArea(
              child: GestureDetector(
            onTap: () {
              UI.push(context, Routes.accountPage);
            },
            onHorizontalDragEnd: (_) =>
                OverlaySupportEntry.of(context).dismiss(),
            child: Card(
              margin: EdgeInsets.all(7),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: ListTile(
                  leading: SizedBox(
                      width: 35,
                      height: 35,
                      child: Icon(Icons.notification_important)),
                  onTap: () {
                    OverlaySupportEntry.of(context).dismiss();
                  },
                  title: Text(title ?? 'test',
                      style: TextStyle(fontSize: 15, color: textColor)),
                  subtitle: Text(body ?? 'test',
                      style: TextStyle(fontSize: 10, color: textColor)),
                  trailing: IconButton(
                      color: textColor,
                      icon: Icon(Icons.close),
                      onPressed: () =>
                          OverlaySupportEntry.of(context).dismiss()),
                ),
              ),
            ),
          ));
        });
  }
}

class NotifyModel extends BaseNotifier {
  final HttpApi api;
  final AuthenticationService auth;
  final BuildContext context;
  NotifyModel({NotifierState state, this.api, this.auth, this.context})
      : super(state: state);
}

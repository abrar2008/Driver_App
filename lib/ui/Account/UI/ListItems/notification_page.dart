import 'package:EfendimDriverApp/core/models/order_detail_info.dart';
import 'package:base_notifier/base_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:EfendimDriverApp/core/api/api.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:EfendimDriverApp/ui/Account/model/notification_page_model.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:EfendimDriverApp/core/localizations/global_translations.dart';

class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<GlobalTranslations>(context, listen: false);
    return BaseWidget<NotificationPageModel>(
      model: NotificationPageModel(
          api: Provider.of<Api>(context),
          auth: Provider.of(context),
          context: context),
      builder: (context, model, child) {
        print(model);
        return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          titleSpacing: 0.0,
          title: Text(lang.translate("notifications").toUpperCase(),
              style: Theme.of(context).textTheme.bodyText1,),
          leading: InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(MdiIcons.arrowLeft, )),
          actions: [IconButton(icon: Icon(Icons.delete), onPressed: () async {model.clearNotification();})],
        ),
        body:  Column(
              children: <Widget>[

                Expanded(
                  // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
                  child: model.busy
                      ? Center(
                          child: SpinKitThreeBounce(
                          size: 82.0,
                          color: Theme.of(context).primaryColor,
                        ))
                      : model.hasError
                          ? Center(
                              child: Text(lang.translate(model.errorString) ??
                                  lang.translate(
                                      "ERROR: Something went wrong")))
                          : ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              itemCount: (model.notificationModel == null ||
                                      model.notificationModel.details == null ||
                                      model.notificationModel.details.length ==
                                          0)
                                  ? 0
                                  : model.notificationModel.details.length,
                              itemBuilder: (BuildContext context, index) {
                                return Card(
                                  elevation:3.5,
                                  color: Theme.of(context).cardColor,
                                  margin: new EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 6.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                        /* color: NewDesign.cardColor */),
                                    child: makeListTile(context, model, index),
                                  ),
                                );
                              },
                            ),
                ),
              ],
        ));
          },
        );
  }

  ListTile makeListTile(
      BuildContext context, NotificationPageModel model, int index){

    var notification = model.notificationModel.details[index];
    return ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        leading: Container(
          padding: EdgeInsets.only(right: 12.0),
          decoration: new BoxDecoration(
              border: new Border(
                  right: new BorderSide(
                    width: 1.0, /* color: NewDesign.coloredIconsColor */
                  ))),
          child: Icon(
            Icons.notifications,
            // color: NewDesign.coloredIconsColor,
            size: 30,
          ),
        ),
        title: Text(
          notification.pushTitle,
          style: TextStyle(
              /* color: NewDesign.blackTextColor, */ fontWeight: FontWeight.bold),
        ),
        // subtitle: Text("Intermediate", style: TextStyle(color: NewDesign.whiteIconsColor)),

        subtitle: Expanded(
              flex: 4,
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 0.0),
                      child: Text(
                        notification.pushMessage,
                        /* style: TextStyle(color: NewDesign.blackTextColor) */
                      )),
                  SizedBox(height: 8,),
                  Container(child: Text(notification.dateCreated, style: TextStyle(fontSize: 14, color: Colors.grey),),
                    alignment: Alignment.bottomRight,)
                ],
              ),
            ),



        // trailing:
        //   Icon(Icons.keyboard_arrow_right, color: NewDesign.whiteIconsColor, size: 30.0),

        onTap: () {
         // Navigator.push(builder:  OrderInfo(orderId: model.notificationModel.details[index].orderId)));
            OrderInfo(orderId: notification.orderId);
        },
    );
  }
}

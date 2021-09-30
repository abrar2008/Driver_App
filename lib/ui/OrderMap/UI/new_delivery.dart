import 'package:EfendimDriverApp/ui/chats/chat_driver_merchant/chat_driver_merchant_controller.dart';
import 'package:EfendimDriverApp/ui/chats/chat_driver_merchant/chat_driver_merchant_page.dart';
import 'package:EfendimDriverApp/ui/chats/chat_support_order/chat_support_order_page.dart';
import 'package:EfendimDriverApp/ui/chats/chat_user_driver/chat_user_driver_controller.dart';
import 'package:EfendimDriverApp/ui/chats/chat_user_driver/chat_user_driver_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:EfendimDriverApp/ui/Components/bottom_bar.dart';
import 'package:EfendimDriverApp/ui/OrderMap/UI/slide_up_panel.dart';
import 'package:EfendimDriverApp/ui/Routes/routes.dart';
import 'package:EfendimDriverApp/ui/Themes/colors.dart';
import 'package:base_notifier/base_notifier.dart';
import 'package:EfendimDriverApp/ui/routes%20copy/route_new.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:EfendimDriverApp/ui/OrderMap/model/new_delivery_model.dart';
import 'package:EfendimDriverApp/core/api/api.dart';
import 'package:EfendimDriverApp/ui/Components/google_maps_widget.dart';
import 'package:ui_utils/ui_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:EfendimDriverApp/core/localizations/global_translations.dart';
import 'package:EfendimDriverApp/core/models/new_order.dart';

class NewDeliveryPage extends StatelessWidget {
  bool isPicked = false;
  bool isAccepted = false;
  bool isOpen = false;

  Details newTask;

  NewDeliveryPage({this.newTask});

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<GlobalTranslations>(context, listen: false);
    print("isAccepted..$isAccepted");

    return BaseWidget<NewDeliveryPageModel>(
      model: NewDeliveryPageModel(
        context: context,
        api: Provider.of<Api>(context),
        auth: Provider.of(context),
        newTask: newTask,
      ),
      builder: (context, model, child) => Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: AppBar(
              title: Text(lang.translate("New delivery task"),
                  style: Theme.of(context).textTheme.bodyText1),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  UI.push(context, Routes.allTasks, replace: true);
                  //  Navigator.pop(context);
                },
              ),
              actions: <Widget>[
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
                  child: FlatButton.icon(
                    icon: Icon(
                      isOpen ? Icons.close : Icons.shopping_basket,
                      color: Colors.white,
                      size: 13.0,
                    ),
                    label: Text(
                        isOpen
                            ? lang.translate("Close")
                            : lang.translate("Order info"),
                        style: Theme.of(context).textTheme.caption.copyWith(
                              fontSize: 11.7,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            )),
                    onPressed: () {
                      if (isOpen)
                        isOpen = false;
                      else
                        isOpen = true;
                      model.setState();
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        body:
            /* model.busy
            ? Center(child: CircularProgressIndicator())
            : model.hasError
                ? Center(
                    child: Text(model.errorMsg),
                  )
                : */
            Stack(
          children: [
            Column(
              children: <Widget>[
                model.busy
                    ? Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                      )
                    : Expanded(
                        child: GoogleMapsWidget(
                          // heigth: ScreenUtil.screenHeightDp * .57,
                          position: model.currentPosition,
                          markers: model.markers,
                          polylines: Set<Polyline>.of(model.polylines.values),
                          usePolylines: true,
                        ),
                      ),
                Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      height: ScreenUtil.screenHeightDp * .07,
                      color: Theme.of(context).cardColor,
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/ride.png',
                            color: kMainColor,
                            scale: 1.8,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              "${model.distance ?? ""} Km",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  .copyWith(
                                      fontSize: 11.7,
                                      letterSpacing: 0.06,
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                          Text(
                            "${model.time ?? ""}n",
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(
                                    fontSize: 11.7,
                                    letterSpacing: 0.06,
                                    color: Color(0xffc1c1c1)),
                          ),
                          Spacer(),
                          // isAccepted
                          //?
                          FlatButton(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            onPressed: () {},
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.navigation,
                                  color: kMainColor,
                                  size: 14.0,
                                ),
                                SizedBox(
                                  width: 8.0,
                                ),
                                InkWell(
                                  onTap: () {
                                    model.launchURL();
                                  },
                                  child: Text(
                                    lang.translate("Get directions"),
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(
                                            color: kMainColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 11.7,
                                            letterSpacing: 0.06),
                                  ),
                                ),
                              ],
                            ),
                          )
                          //: SizedBox.shrink(),
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(
                                left: 28.0, bottom: 6.0, top: 6.0, right: 10.0),
                            child: Icon(
                              Icons.location_on,
                              size: 14.0,
                              color: kMainColor,
                            )),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: ScreenUtil.screenWidthDp * .6,
                              child: Text(
                                model.newTask.merchantName ?? "NOT DEFINED",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                        fontSize: 15,
                                        letterSpacing: 0.05,
                                        fontWeight: FontWeight.bold),
                              ),
                            ),
                            /*  SizedBox(
                              height: 10.0,
                            ),
                             if (model.newTask.contactNumber != null &&
                                model.newTask.contactNumber.isNotEmpty)
                              Container(
                                width: ScreenUtil.screenWidthDp * .6,
                                child: Text(
                                  model.newTask.contactNumber,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                          fontSize: 13.0, letterSpacing: 0.05),
                                ),
                              ),
                            SizedBox(
                              height: 10,
                            ),*/
                            if (model.newTask.merchantAddress != null &&
                                model.newTask.merchantAddress.isNotEmpty)
                              Container(
                                width: ScreenUtil.screenWidthDp * .6,
                                child: Text(
                                  model.newTask.merchantAddress,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      .copyWith(
                                          fontSize: 15.0,
                                          letterSpacing: 0.05,
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
                          ],
                        ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: Row(
                              children: <Widget>[
                                // IconButton(
                                //   icon: Icon(
                                //     Icons.message,
                                //     color: kMainColor,
                                //     size: 14.0,
                                //   ),
                                //   onPressed: () {
                                //     UI.push(context, Routes.chatPageRestaurant);
                                //     // Navigator.pushNamed(context,
                                //     //     PageRoutes.chatPageRestaurant);
                                //   },
                                // ),
                                IconButton(
                                  icon: Icon(
                                    Icons.phone,
                                    color: kMainColor,
                                    size: 14.0,
                                  ),
                                  onPressed: () async {
                                    final url = "tel:" +
                                            model
                                                .newTask.dropoffContactNumber ??
                                        "";
                                    await canLaunch(url)
                                        ? await launch(url)
                                        : throw 'Could not launch $url';
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(
                                left: 28.0, bottom: 6.0, top: 6.0, right: 10.0),
                            child: Icon(
                              Icons.location_on,
                              size: 14.0,
                              color: kMainColor,
                            )),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: ScreenUtil.screenWidthDp * .6,
                              child: Text(
                                model.newTask.customerName ?? "",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                        fontSize: 15,
                                        letterSpacing: 0.05,
                                        fontWeight: FontWeight.bold),
                              ),
                            ),
                            /*  SizedBox(
                              height: 10.0,
                            ),
                             if (model.newTask.contactNumber != null &&
                                model.newTask.contactNumber.isNotEmpty)
                              Container(
                                width: ScreenUtil.screenWidthDp * .6,
                                child: Text(
                                  model.newTask.contactNumber,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                          fontSize: 13.0, letterSpacing: 0.05),
                                ),
                              ),
                            SizedBox(
                              height: 10,
                            ),*/
                            if (model.newTask.deliveryAddress != null &&
                                model.newTask.deliveryAddress.isNotEmpty)
                              Container(
                                width: ScreenUtil.screenWidthDp * .6,
                                child: Text(
                                  model.newTask.deliveryAddress,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      .copyWith(
                                          fontSize: 15.0,
                                          letterSpacing: 0.05,
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
                          ],
                        ),
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.0),
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: Row(
                              children: <Widget>[
                                // IconButton(
                                //   icon: Icon(
                                //     Icons.message,
                                //     color: kMainColor,
                                //     size: 14.0,
                                //   ),
                                //   onPressed: () {
                                //     UI.push(context, Routes.chatPageRestaurant);
                                //     // Navigator.pushNamed(context,
                                //     //     PageRoutes.chatPageRestaurant);
                                //   },
                                // ),
                                IconButton(
                                  icon: Icon(
                                    Icons.phone,
                                    color: kMainColor,
                                    size: 14.0,
                                  ),
                                  onPressed: () async {
                                    final url = "tel:" +
                                            model
                                                .newTask.dropoffContactNumber ??
                                        "";
                                    await canLaunch(url)
                                        ? await launch(url)
                                        : throw 'Could not launch $url';
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.0,
                    ),
                    _buildChatButtons(model),
                    SizedBox(
                      height: 10.0,
                    ),
                    model.waiting
                        ? model.changingOrderStatus
                            ? Center(
                                child: CircularProgressIndicator(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                ),
                              )
                            : Row(
                                children: [
                                  Expanded(
                                    child: BottomBar(
                                        color: Colors.green,
                                        text: lang.translate(
                                            model.newTask.status ==
                                                    "acknowledged"
                                                ? "Start"
                                                : "Accept"),
                                        onTap: () async {
                                          showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text(lang.translate(
                                                      "Change Task Status")),
                                                  content: Text(lang.translate(
                                                      "Did you Want to Change Task Staus")),
                                                  actions: <Widget>[
                                                    FlatButton(
                                                      child: Text(lang
                                                          .translate("no")
                                                          .toUpperCase()),
                                                      textColor: kMainColor,
                                                      shape: RoundedRectangleBorder(
                                                          side: BorderSide(
                                                              color:
                                                                  kTransparentColor)),
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                    ),
                                                    FlatButton(
                                                        child: Text(lang
                                                            .translate("yes")
                                                            .toUpperCase()),
                                                        shape: RoundedRectangleBorder(
                                                            side: BorderSide(
                                                                color:
                                                                    kTransparentColor)),
                                                        textColor: kMainColor,
                                                        onPressed: () async {
                                                          await model.changeStatusOrder(
                                                              status: model.newTask
                                                                          .status ==
                                                                      "acknowledged"
                                                                  ? OrderStatus
                                                                      .STARTED
                                                                  : OrderStatus
                                                                      .ACKNOWLEDGED);
                                                          Navigator.pop(
                                                              context);
                                                        })
                                                  ],
                                                );
                                              });
                                        }),
                                  ),
                                  SizedBox(width: 12),
                                  Expanded(
                                    child: BottomBar(
                                        text: lang.translate("Decline"),
                                        onTap: () async {
                                          showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text(lang.translate(
                                                      "Change Task Status")),
                                                  content: Text(lang.translate(
                                                      "Are you sure want to decline order?")),
                                                  actions: <Widget>[
                                                    FlatButton(
                                                      child: Text(lang
                                                          .translate("no")
                                                          .toUpperCase()),
                                                      textColor: kMainColor,
                                                      shape: RoundedRectangleBorder(
                                                          side: BorderSide(
                                                              color:
                                                                  kTransparentColor)),
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                    ),
                                                    FlatButton(
                                                        child: Text(lang
                                                            .translate("yes")
                                                            .toUpperCase()),
                                                        shape: RoundedRectangleBorder(
                                                            side: BorderSide(
                                                                color:
                                                                    kTransparentColor)),
                                                        textColor: kMainColor,
                                                        onPressed: () async {
                                                          await model
                                                              .changeStatusOrder(
                                                                  status: OrderStatus
                                                                      .DECLINED);
                                                          Navigator.pop(
                                                              context);
                                                          UI.toast(lang.translate(
                                                              "Order has been declined successfully!"));
                                                          Future.delayed(
                                                              Duration(
                                                                  milliseconds:
                                                                      200), () {
                                                            Navigator.pop(
                                                                context);
                                                          });
                                                        })
                                                  ],
                                                );
                                              });
                                        }),
                                  )
                                ],
                              )
                        : model.isStarted
                            ? model.changingOrderStatus
                                ? Center(
                                    child: CircularProgressIndicator(
                                      backgroundColor:
                                          Theme.of(context).primaryColor,
                                    ),
                                  )
                                : BottomBar(
                                    text: lang.translate("In progress"),
                                    onTap: () async {
                                      showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: Text(lang.translate(
                                                  "Change Task Status")),
                                              content: Text(lang.translate(
                                                  "Did you Want to Change Task Staus")),
                                              actions: <Widget>[
                                                FlatButton(
                                                  child: Text(lang
                                                      .translate("no")
                                                      .toUpperCase()),
                                                  textColor: kMainColor,
                                                  shape: RoundedRectangleBorder(
                                                      side: BorderSide(
                                                          color:
                                                              kTransparentColor)),
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                ),
                                                FlatButton(
                                                    child: Text(lang
                                                        .translate("yes")
                                                        .toUpperCase()),
                                                    shape: RoundedRectangleBorder(
                                                        side: BorderSide(
                                                            color:
                                                                kTransparentColor)),
                                                    textColor: kMainColor,
                                                    onPressed: () async {
                                                      await model
                                                          .changeStatusOrder(
                                                              status: OrderStatus
                                                                  .INPROGRESS);
                                                      Navigator.pop(context);
                                                    })
                                              ],
                                            );
                                          });
                                    })
                            : model.isPicked
                                ? model.changingOrderStatus
                                    ? Center(
                                        child: CircularProgressIndicator(
                                          backgroundColor:
                                              Theme.of(context).primaryColor,
                                        ),
                                      )
                                    : BottomBar(
                                        text: lang.translate("Delivered"),
                                        onTap: () async {
                                          showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: Text(lang.translate(
                                                      "Change Task Status")),
                                                  content: Text(lang.translate(
                                                      "Did you Want to Change Task Staus")),
                                                  actions: <Widget>[
                                                    FlatButton(
                                                      child: Text(lang
                                                          .translate("no")
                                                          .toUpperCase()),
                                                      textColor: kMainColor,
                                                      shape: RoundedRectangleBorder(
                                                          side: BorderSide(
                                                              color:
                                                                  kTransparentColor)),
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                    ),
                                                    FlatButton(
                                                        child: Text(lang
                                                            .translate("yes")
                                                            .toUpperCase()),
                                                        shape: RoundedRectangleBorder(
                                                            side: BorderSide(
                                                                color:
                                                                    kTransparentColor)),
                                                        textColor: kMainColor,
                                                        onPressed: () async {
                                                          // Phoenix.rebirth(context);
                                                          await model.changeStatusOrder(
                                                              status: OrderStatus
                                                                  .SUCCESSFUL);
                                                          Navigator.pop(
                                                              context);
                                                        })
                                                  ],
                                                );
                                              });
                                        })
                                : Container()
                  ],
                )
              ],
            ),
            isOpen
                ? OrderInfoContainer(orderDetailModel: model.orderDetailInfo)
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Widget _buildChatButtons(NewDeliveryPageModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton.icon(
            label: Text('Merchant'),
            icon: Image.asset(
              'assets/icons/chat_merchant.png',
              //color: kMainColor,
              scale: 1.8,
              height: 20,
              width: 20,
              fit: BoxFit.fill,
            ),
            /*Icon(
           /   Icons.message,
              color: kMainColor,
              size: 14.0,
            )*/
            onPressed: () {
              Get.to(
                ChatDriverMerchantPage(),
                arguments: ChatDriverMerchantParams(
                  orderId: newTask.orderId,
                  merchantPhone: model.newTask.contactNumber,
                ),
              );
            },
          ),
          SizedBox(width: 10),
          TextButton.icon(
            label: Text('User'),
            icon: Image.asset(
              'assets/icons/chat_customer.png',
              //color: kMainColor,
              scale: 1.8,
              height: 20,
              width: 20,
              fit: BoxFit.fill,
            ),
            onPressed: () {
              Get.to(
                ChatUserDriverPage(),
                arguments: ChatUserDriverParams(
                  orderId: newTask.orderId,
                  userPhone: model.newTask.dropoffContactNumber,
                ),
              );
            },
          ),
          SizedBox(width: 10),
          TextButton.icon(
            label: Text('Support'),
            icon: Image.asset(
              'assets/icons/chat_support.png',
              //color: kMainColor,
              scale: 1.8,
              height: 20,
              width: 20,
              fit: BoxFit.fill,
            ),
            onPressed: () {
              Get.to(
                ChatSupportOrderPage(),
                arguments: newTask.orderId,
              );
            },
          ),
        ],
      ),
    );
  }
}

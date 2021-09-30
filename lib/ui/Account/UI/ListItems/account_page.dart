import 'package:EfendimDriverApp/ui/Account/UI/ListItems/contact_us.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ui_utils/ui_utils.dart';
import 'package:EfendimDriverApp/ui/routes%20copy/route_new.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:EfendimDriverApp/ui/Components/list_tile.dart';
import 'package:EfendimDriverApp/ui/Themes/colors.dart';
import 'package:EfendimDriverApp/core/api/api.dart';
import 'package:base_notifier/base_notifier.dart';
import 'package:provider/provider.dart';
import 'package:EfendimDriverApp/core/auth/authentication_service.dart';
import 'package:EfendimDriverApp/ui/Account/model/account_page_model.dart';
import 'package:EfendimDriverApp/core/localizations/global_translations.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:EfendimDriverApp/ui/Components/bottom_bar.dart';
import 'package:lottie/lottie.dart';

class AccountDrawer extends StatelessWidget {
  AccountPagePageModel model;

  AccountDrawer({this.model});

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<GlobalTranslations>(context, listen: false);
    return Drawer(
      child: ListView(
        children: <Widget>[
          Container(
            child: UserDetails(),
            height: 220.0,
          ),
          Divider(
            color: Theme.of(context).cardColor,
            thickness: 8.0,
          ),
          BuildListTile(
              image: 'assets/images/ic_menu_home.png',
              // image: 'assets/images/account/svg/account_shop.svg',
              text: lang.translate("Home"),
              onTap: () => UI.push(context, Routes.accountPage)),
          BuildListTile(
              image: 'assets/images/notification.png',
              text: lang.translate("Notificaton"),
              onTap: () => UI.push(
                    context,
                    Routes.notification,
                  )),
          !model.accountstatus
              ? BuildListTile(
                  useImageWidget: true,
                  imageWidget: Icon(
                    MdiIcons.fileDocument,
                    color: kMainColor,
                  ),
                  text: lang.translate("Task History"),
                  onTap: () => UI.push(
                        context,
                        Routes.history,
                      ))
              : !model.accountstatus
                  ? BuildListTile(
                      image: 'assets/images/ic_menu_wallet.png',
                      // image: 'assets/images/account/svg/account_ic_menu_wallet.svg',
                      text: lang.translate("Wallet"),
                      onTap: () => UI.push(context, Routes.walletPage),
                    )
                  : Spacer(),
          BuildListTile(
              image: 'assets/images/ic_menu_tncact.png',
              // image: 'assets/images/account/svg/account_ic_menu_tncact.svg',
              text: lang.translate("Terms and Conditions"),
              onTap: () => UI.push(context, Routes.tncPage)),
          BuildListTile(
              image: 'assets/images/ic_menu_supportact.png',
              // image: 'assets/images/account/svg/account_ic_menu_supportact.svg',
              text: lang.translate("Contact Support"),
              onTap: () {
                UI.push(context, ContactUs());
              }),
          BuildListTile(
              image: 'assets/images/ic_menu_setting.png',
              // image: 'assets/images/account/svg/account_shop.svg',
              text: lang.translate("Update_profile"),
              onTap: () => UI
                  .push(context, Routes.profilePage)
                  .then((value) async => model.getProfile())),
          BuildListTile(
              image: 'assets/images/ic_menu_setting.png',
              // image: 'assets/images/account/svg/account_ic_menu_setting.svg',
              text: lang.translate('Settings'),
              onTap: () => UI.push(context, Routes.settings)
              /*  .then((value) => model.setState()), */
              ),
          LogoutTile(),
        ],
      ),
    );
  }
}

class AccountPage extends StatelessWidget {
  bool isoffline = false;

  @override
  Widget build(BuildContext context) {
    return BaseWidget<AccountPagePageModel>(
        model: AccountPagePageModel(
            auth: Provider.of(context),
            api: Provider.of<Api>(context),
            context: context),
        // initState: (m) => WidgetsBinding.instance.addPostFrameCallback((_) async {

        // }),
        builder: (context, model, child) {
          final GlobalTranslations lang =
              Provider.of<GlobalTranslations>(context, listen: false);
          return Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(80.0),
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: AppBar(
                    title: !model.accountstatus
                        ? Text(
                            model.offline
                                ? lang.translate("Offline")
                                : lang.translate("Online"),
                            style: Theme.of(context)
                                .textTheme
                                .headline4
                                .copyWith(fontWeight: FontWeight.w500))
                        : Spacer(),
                    actions: <Widget>[
                      !model.accountstatus
                          ? Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: model.offline
                                  ? FlatButton(
                                      color: Color.fromRGBO(0, 128, 0, 0),
                                      onPressed: () async {
                                        isoffline = false;
                                        // await model.getLocation();
                                        await model.changeDutyStatue(
                                            isOnline: true);
                                        await model.getNewTask();
                                        model.setState();
                                      },
                                      child: Text(
                                        lang.translate("Go online"),
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .copyWith(
                                                color: kWhiteColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 11.7,
                                                letterSpacing: 0.06),
                                      ),
                                    )
                                  : FlatButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(18.0),
                                          side: BorderSide(
                                              color: Color(0xffff3939))),
                                      color: Color(0xffff3939),
                                      onPressed: () async {
                                        await model.changeDutyStatue(
                                            isOnline: false);
                                        model.newOrderModel = null;
                                        model.setState();

                                        // Navigator.popAndPushNamed(context, PageRoutes.offlinePage);
                                      },
                                      child: Text(
                                        lang.translate("Go offline"),
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .copyWith(
                                                color: kWhiteColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 11.7,
                                                letterSpacing: 0.06),
                                      ),
                                    ),
                            )
                          : Spacer(),
                    ]),
              ),
            ),
            drawer: AccountDrawer(model: model),
            body: Stack(
              children: <Widget>[
                model.busy
                    ? Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                      )
                    : /* GoogleMapsWidget(
                        position: model.currentPosition,
                        markers: model.markers,
                      ),
                      
                       */

                    model.accountstatus
                        ? Scaffold(
                            // appBar: CustomAppBar(
                            //
                            //   title: AppLocalizations.of(context).orderText,
                            //   preferredSize: Size.fromHeight(96.0),
                            //
                            // ),

                            body: Container(
                              alignment: Alignment.center,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Lottie.asset(
                                      'assets/animation/merchant-confirm.json'),
                                  SizedBox(
                                    height: 16.0,
                                  ),
                                  Text(
                                    'Your Account is under review.',
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  // SizedBox(height: 32.0,),
                                  Container(
                                      padding: EdgeInsets.all(32.0),
                                      child: ElevatedButton(
                                        onPressed: () =>
                                            UI.push(context, ContactUs()),
                                        child: Text(
                                          lang.translate("Contact Support"),
                                        ),
                                      )),
                                ],
                              ),
                            ),
                          )
                        : model.offline
                            ? Center(
                                child:
                                    Text(lang.translate("You must be online")),
                              )
                            : model.hasError
                                ? Center(
                                    child: Text(model.errorMsg),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                        height:
                                            ScreenUtil.screenHeightDp / 1.90,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            border:
                                                Border.all(color: kMainColor)),
                                        child: Column(
                                          children: [
                                            buildNewTaskDetails(model: model),
                                            model.changingOrderStatus
                                                ? Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      backgroundColor:
                                                          Theme.of(context)
                                                              .primaryColor,
                                                    ),
                                                  )
                                                : BottomBar(
                                                    text: lang
                                                        .translate("accept")
                                                        .toUpperCase(),
                                                    onTap: () async {
                                                      await model
                                                          .changeStatusOrder(
                                                              status:
                                                                  OrderStatus
                                                                      .STARTED);

                                                      if (model.isAccepted) {
                                                        UI
                                                            .push(
                                                                context,
                                                                Routes.newDeliveryPage(
                                                                    newTask: model
                                                                        .newOrderModel
                                                                        .details))
                                                            .then((value) async =>
                                                                await model
                                                                    .getNewTask());
                                                      }
                                                    })
                                          ],
                                        )),
                                  ),
                model.offline
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          margin: EdgeInsets.all(20.0),
                          color: Theme.of(context).scaffoldBackgroundColor,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    model.auth.userProfile.details.totalTask
                                            .toString() ??
                                        "0",
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    lang.translate("orders").toUpperCase(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff6a6c74)),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    model.auth.userProfile.details.totalDistance
                                            .toString() +
                                        " Km",
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    lang.translate("ride"),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff6a6c74)),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    '\$' +
                                        model.auth.userProfile.details
                                            .driverBalance
                                            .toString(),
                                    style:
                                        Theme.of(context).textTheme.headline4,
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  Text(
                                    lang.translate("Earnings"),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline6
                                        .copyWith(
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff6a6c74)),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            ),
            floatingActionButton: model.offline
                ? null
                : model.accountstatus
                    ? null
                    : FloatingActionButton(
                        backgroundColor: kMainColor,
                        child: Icon(Icons.refresh),
                        onPressed: () => model.getNewTask()),
          );
        });
  }

  Widget buildRowItem(
      {@required String title, @required String value, @required Widget icon}) {
    title = title == null ? " " : title;
    value = value == null ? " " : value;
    final String txt = title + ": " + value;
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          icon,
          SizedBox(
            width: ScreenUtil.screenWidthDp / 30,
          ),
          Expanded(
            child:
                Text(txt ?? " ", style: TextStyle(fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  Widget buildGoogleMapWidget(AccountPagePageModel model) {
    LatLng pos =
        LatLng(model.currentPosition.latitude, model.currentPosition.longitude);
    return GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: pos,
          zoom: 8,
        ),
        onMapCreated: (GoogleMapController controller) {
          model.mapsController = controller;
          model.setState();
        },
        markers: model.markers);
  }

  buildNewTaskDetails({AccountPagePageModel model}) {
    final newOrder = model.newOrderModel.details;

    final lang = Provider.of<GlobalTranslations>(model.context, listen: false);
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                buildRowItem(
                    icon: Icon(MdiIcons.clockOutline),
                    title: lang.translate("Time"),
                    value: newOrder.dateCreated),

                buildRowItem(
                    icon: Icon(MdiIcons.fileDocument),
                    title: lang.translate("task_id").toUpperCase(),
                    value: newOrder.taskId),
                buildRowItem(
                    icon: Icon(Icons.person),
                    title: lang.translate("Customer Name").toUpperCase(),
                    value: newOrder.dropoffContactName),
                buildRowItem(
                    icon: Icon(Icons.call),
                    title: lang.translate("Contact Number"),
                    value: newOrder.dropoffContactNumber),
                // buildRowItem(
                //     icon: Icon(Icons.store),
                //     title: lang.translate("Merchant name"),
                //     value: newOrder.merchantName),
                buildRowItem(
                    icon: Icon(Icons.branding_watermark),
                    title: lang.translate("Order No."),
                    value: newOrder.orderId),
                // buildRowItem(
                //     icon: Icon(MdiIcons.listStatus),
                //     title: lang.translate("Order status"),
                //     value: newOrder.orderStatus),
                // buildRowItem(
                //     icon: Icon(Icons.payment),
                //     title: lang.translate("Payment type"),
                //     value: newOrder.paymentType),
                buildRowItem(
                    icon: Icon(Icons.flag),
                    title: lang.translate("Delivery Address"),
                    value: newOrder.dropAddress),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LogoutTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalTranslations lang =
        Provider.of<GlobalTranslations>(context, listen: false);
    return BuildListTile(
      image: 'assets/images/ic_menu_logoutact.png',
      // image: 'assets/images/account/svg/account_ic_menu_logoutact.svg',
      text: lang.translate("logout"),
      onTap: () {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(lang.translate("logout")),
                content: Text(lang.translate("logout_confirm")),
                actions: <Widget>[
                  FlatButton(
                    child: Text(lang.translate("no").toUpperCase()),
                    textColor: kMainColor,
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: kTransparentColor)),
                    onPressed: () => Navigator.pop(context),
                  ),
                  FlatButton(
                      child: Text(lang.translate("yes").toUpperCase()),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: kTransparentColor)),
                      textColor: kMainColor,
                      onPressed: () {
                        // Phoenix.rebirth(context);
                        Provider.of<AuthenticationService>(context,
                                listen: false)
                            .signOut;
                        UI.pushReplaceAll(context, Routes.phoneNumber);
                      })
                ],
              );
            });
      },
    );
  }
}

class UserDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final AuthenticationService auth =
    //     Provider.of<AuthenticationService>(context, listen: false);
    final lang = Provider.of<GlobalTranslations>(context, listen: false);
    return Consumer<AccountPagePageModel>(
      builder: (context, model, child) => model.gettingProfile
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Theme.of(context).primaryColor,
              ),
            )
          : model.gettingProfileError
              ? Center(
                  child: Text(lang.translate("ERROR: Something went wrong")))
              : Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Container(
                    decoration: BoxDecoration(
                        border: Border.all(
                            width: 4.0,
                            color:
                                Color(Theme.of(context).primaryColor.value))),
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          radius: 32,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: CircleAvatar(
                              // backgroundColor: AppColors.mainColor,
                              radius: ScreenUtil.screenWidthDp / 4,
                              child: CachedNetworkImage(
                                  width: double.infinity,
                                  height: double.infinity,
                                  imageUrl: model.auth.userProfile?.details
                                          ?.profilePhoto ??
                                      " ",
                                  fit: BoxFit.cover,
                                  errorWidget: (context, url, error) =>
                                      Image.asset('assets/images/Logo.png'),
                                  placeholder: (context, url) => Center(
                                          child: CircularProgressIndicator(
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                      ))),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        InkWell(
                          // onTap: () => Navigator.pushNamed(context, PageRoutes.editProfile),
                          onTap: () => UI
                              .push(context, Routes.profilePage)
                              .then((value) async => model.getProfile()),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: ScreenUtil.screenWidthDp / 3,
                                child: Text(
                                    '\n' +
                                            model.auth.userProfile.details
                                                .fullName ??
                                        "User",
                                    style:
                                        Theme.of(context).textTheme.bodyText1),
                              ),
                              Container(
                                width: ScreenUtil.screenWidthDp / 3,
                                child: Text(
                                    '\n' +
                                            model.auth.userProfile.details
                                                .email ??
                                        " ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .copyWith(color: Color(0xff9a9a9a))),
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
                              Container(
                                width: ScreenUtil.screenWidthDp / 3,
                                child: Text(
                                    model.auth.userProfile.details.phone ?? " ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .copyWith(color: Color(0xff9a9a9a))),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
    );
  }
}

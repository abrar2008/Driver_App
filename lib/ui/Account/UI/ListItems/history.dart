import 'package:EfendimDriverApp/core/auth/authentication_service.dart';
import 'package:EfendimDriverApp/core/models/new_order.dart';
import 'package:EfendimDriverApp/ui/Account/UI/ListItems/contact_us.dart';
import 'package:EfendimDriverApp/ui/Account/model/histotmodal.dart';
import 'package:EfendimDriverApp/ui/Components/list_tile.dart';
import 'package:EfendimDriverApp/ui/DeliveryPartnerProfile/delivery_profile.dart';
import 'package:EfendimDriverApp/ui/Themes/style.dart';
import 'package:base_notifier/base_notifier.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:ui_utils/ui_utils.dart';
import 'package:EfendimDriverApp/ui/Account/model/all_tasks_page_model.dart';
import 'package:EfendimDriverApp/core/api/api.dart';
import 'package:EfendimDriverApp/core/localizations/global_translations.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:EfendimDriverApp/ui/Themes/colors.dart';
import 'package:EfendimDriverApp/ui/routes copy/route_new.dart';
import 'package:toaster/toaster.dart';
import 'package:expand_widget/expand_widget.dart';

class AccountDrawer extends StatelessWidget {
  HistoryPageModel model;

  AccountDrawer({this.model});
  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<GlobalTranslations>(context, listen: false);
    return Drawer(
      elevation: 7.0,
      semanticLabel: 'hello',
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
              onTap: () => UI.push(context, Routes.allTasks)),
          BuildListTile(
              image: 'assets/images/notification.png',
              text: lang.translate("Notificaton"),
              onTap: () => UI.push(
                    context,
                    Routes.notification,
                  )),
          model != null && model.accountstatus != null && !model.accountstatus
              ? BuildListTile(
                  image: 'assets/images/ic_menu_insight.png',
                  text: lang.translate("Task History"),
                  onTap: () => UI.push(
                        context,
                        Routes.history,
                      ))
              : SizedBox(height: 0),
          !model.accountstatus
              ? BuildListTile(
                  image: 'assets/images/ic_menu_wallet.png',
                  // image: 'assets/images/account/svg/account_ic_menu_wallet.svg',
                  text: lang.translate("Wallet"),
                  onTap: () => UI.push(context, Routes.walletPage),
                )
              : SizedBox(height: 0),
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
              text: lang.translate("Update Profile"),
              onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProfilePage(status: model.accountstatus ? 1 : 0)),
                  )
                      //UI.push(context, Routes.profilePage)
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

class LogoutTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalTranslations lang =
        Provider.of<GlobalTranslations>(context, listen: false);
    return BuildListTile(
      image: 'assets/images/ic_menu_logoutact.png',
      // image: 'assets/images/account/svg/account_ic_menu_logoutact.svg',
      text: lang.translate("Logout"),
      onTap: () {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(lang.translate("Logout")),
                content: Text(lang.translate("Logout_confirm")),
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
    return Consumer<HistoryPageModel>(
      builder: (context, model, child) => model.gettingProfile
          ? Center(
              child: CircularProgressIndicator(),
            )
          : model.gettingProfileError
              ? Center(
                  child: Text(
                  lang.translate("ERROR: Something went wrong"),
                  overflow: TextOverflow.clip,
                ))
              : Padding(
                  padding: EdgeInsets.all(16.0),
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
                        width: 14.0,
                      ),
                      Expanded(
                        child: InkWell(
                          // onTap: () => Navigator.pushNamed(context, PageRoutes.editProfile),
                          onTap: () =>

                              // UI .push(context, Routes.profilePage)
                              Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ProfilePage(
                                              status:
                                                  model.accountstatus ? 1 : 0)))
                                  .then((value) async => model.getProfile()),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              Text(
                                  '\n' +
                                          model.auth.userProfile.details
                                              .fullName ??
                                      "User",
                                  style: Theme.of(context).textTheme.headline4),
                              Text(
                                  '\n' + model.auth.userProfile.details.email ??
                                      " ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      .copyWith(color: Color(0xff9a9a9a)),
                                  overflow: TextOverflow.clip),
                              SizedBox(
                                height: 5.0,
                              ),
                              Text(model.auth.userProfile.details.phone ?? " ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle2
                                      .copyWith(color: Color(0xff9a9a9a)),
                                  overflow: TextOverflow.ellipsis),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
    );
  }
}

class History extends StatelessWidget {
  bool isoffline = false;
  void _onViewChanged(ViewChangedDetails visibleDatesChangedDetails) {
    SchedulerBinding.instance?.addPostFrameCallback((_) {
      final DateTime currentViewDate = visibleDatesChangedDetails
          .visibleDates[visibleDatesChangedDetails.visibleDates.length ~/ 2];

      if (currentViewDate.month == DateTime.now().month &&
          currentViewDate.year == DateTime.now().year) {
        _calendarController.selectedDate = DateTime.now();
      } else {
        _calendarController.selectedDate =
            DateTime(currentViewDate.year, currentViewDate.month, 01);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FocusWidget(
        child: BaseWidget<HistoryPageModel>(
            //initState: (m) => WidgetsBinding.instance.addPostFrameCallback((_) => m.initializeProfileData()),
            model: HistoryPageModel(
                api: Provider.of<Api>(context),
                auth: Provider.of(context),
                context: context),
            builder: (context, model, child) {
              final lang =
                  Provider.of<GlobalTranslations>(context, listen: false);
              return Scaffold(
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                drawer: AccountDrawer(
                  model: model,
                ),
                body: BaseWidget<HistoryPageModel>(
                    //initState: (m) => WidgetsBinding.instance.addPostFrameCallback((_) => m.initializeProfileData()),
                    model: HistoryPageModel(
                        api: Provider.of<Api>(context),
                        auth: Provider.of(context),
                        context: context),
                    builder: (context, model, child) {
                      final lang = Provider.of<GlobalTranslations>(context,
                          listen: false);
                      return Scaffold(
                        floatingActionButton: model.offline
                            ? null
                            : model.accountstatus
                                ? null
                                : FloatingActionButton(
                                    backgroundColor: Theme.of(context)
                                        .floatingActionButtonTheme
                                        .backgroundColor,
                                    child:
                                        Icon(Icons.refresh, color: kIconColor),
                                    onPressed: () => model.getAllTask()),
                        appBar: PreferredSize(
                          preferredSize: Size.fromHeight(80.0),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: AppBar(
                                backgroundColor: Theme.of(context).primaryColor,
                                title: !model.accountstatus
                                    ? Text(
                                        model.offline
                                            ? lang.translate("You're Online")
                                            : lang.translate("You're Online"),
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline4
                                            .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white))
                                    : SizedBox(height: 0),
                                actions: <Widget>[
                                  !model.accountstatus
                                      ? Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: model.offline
                                              ? FlatButton(
                                                  color: Colors.red,
                                                  onPressed: () async {
                                                    isoffline = false;
                                                    // await model.getLocation();
                                                    await model
                                                        .changeDutyStatue(
                                                            isOnline: true);
                                                    await model.getAllTask();
                                                    model.setState();
                                                    Toaster.toast(
                                                        message:
                                                            "Your are Online",
                                                        duration:
                                                            Duration.LONG);
                                                  },
                                                  child: Text(
                                                    lang.translate("Offline"),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .caption
                                                        .copyWith(
                                                            color: kWhiteColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 11.7,
                                                            letterSpacing:
                                                                0.06),
                                                  ),
                                                )
                                              : FlatButton(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            18.0),
                                                  ),
                                                  color: Colors.green,
                                                  onPressed: () async {
                                                    await model
                                                        .changeDutyStatue(
                                                            isOnline: false);
                                                    model.newOrderModel = null;
                                                    model.setState();

                                                    Toaster.toast(
                                                        message:
                                                            "Your are Offline ",
                                                        duration:
                                                            Duration.LONG);
                                                    // Navigator.popAndPushNamed(context, PageRoutes.offlinePage);
                                                  },
                                                  child: Text(
                                                    lang.translate("Online"),
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .caption
                                                        .copyWith(
                                                            color: kWhiteColor,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 11.7,
                                                            letterSpacing:
                                                                0.06),
                                                  ),
                                                ),
                                        )
                                      : SizedBox(height: 0),
                                ]),
                          ),
                        ),
                        drawer: AccountDrawer(
                          model: model,
                        ),
                        body: model.accountstatus
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                      SizedBox(height: 16.0),
                                      if (model.auth.userProfile.details
                                          .licencePlate.isEmpty) ...[
                                        Text(
                                          lang.translate(
                                              'Please upload document and complete your profile.'),
                                          style: TextStyle(
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w500),
                                          textAlign: TextAlign.center,
                                        ),
                                        Container(
                                            padding: EdgeInsets.all(32.0),
                                            child: ElevatedButton(
                                              onPressed: () => UI.push(
                                                  context, ProfilePage()),
                                              child: Text(
                                                lang.translate(
                                                    "Update Profile"),
                                              ),
                                            )),
                                      ],
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
                            : SfCalendar(
                                onTap: (CalendarTapDetails details) {
                                  print(details.targetElement);

                                  DateTime date = details.date;
                                  dynamic appointments = details.appointments;
                                  CalendarElement view = details.targetElement;
                                },
                                onViewChanged: _onViewChanged,
                                view: CalendarView.month,
                                dataSource: MeetingDataSource(model.listtask),
                                monthViewSettings: MonthViewSettings(
                                    appointmentDisplayMode:
                                        MonthAppointmentDisplayMode
                                            .appointment)),
                      );
                    }),
              );
            }));
  }

  final CalendarController _calendarController = CalendarController();
  Orientation _deviceOrientation;

  Widget buildTopButtons(AllTasksPageModel model, GlobalTranslations lang) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: TextButton(
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(
                      model.selection == 0 ? Colors.white : Colors.black),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      model.selection == 0 ? kMainColor : Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                          side: BorderSide(color: Colors.red)))),
              onPressed: () async {
                model.selection = 0;
                model.setState();
                model.getAllTask();
              },
              child: Text(
                lang.translate("Pending Task").toUpperCase(),
                style: TextStyle(
                    fontSize: 10,
                    color: model.selection == 0 ? Colors.white : Colors.black),
              ),
              // color: model.selection == 0 ? kMainColor : Colors.white,
            ),
          ),
        ),
        /* Expanded(
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: RaisedButton(
              onPressed: () async {
                model.selection = 1;

                model.getAllTask();
                model.setState();
              },
              child: Text(
                lang.translate("Started").toUpperCase(),
                style: TextStyle(fontSize: 10, color: model.selection == 1 ? Colors.white : Colors.black),
                textAlign: TextAlign.center,
              ),
              color: model.selection == 1 ? kMainColor : Colors.white,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: RaisedButton(
              onPressed: () async {
                model.selection = 2;

                model.getAllTask();
                model.setState();
              },
              child: Text(
                lang.translate("in progress").toUpperCase(),
                style: TextStyle(fontSize: 10, color: model.selection == 2 ? Colors.white : Colors.black),
                textAlign: TextAlign.center,
              ),
              color: model.selection == 2 ? kMainColor : Colors.white,
            ),
          ),
        ),*/
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: TextButton(
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(
                      model.selection == 3 ? Colors.white : Colors.black),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      model.selection == 3 ? kMainColor : Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                          side: BorderSide(color: Colors.red)))),
              onPressed: () async {
                model.selection = 3;

                model.getAllTask();
                model.setState();
              },
              child: Text(
                lang.translate("Completed Task").toUpperCase(),
                style: TextStyle(
                    fontSize: 10,
                    color: model.selection == 3 ? Colors.white : Colors.black),
                textAlign: TextAlign.center,
              ),
              // color: model.selection == 3 ? kMainColor : Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  Widget buildBody(AllTasksPageModel model, GlobalTranslations lang, context) {
    return Expanded(
      child: model.busy
          ? Container(
              child: Center(
                  child: CircularProgressIndicator(
              backgroundColor: Theme.of(context).primaryColor,
            )))
          : model != null &&
                  model.tasksModel != null &&
                  model.tasksModel.details != null &&
                  model.tasksModel.details.data != null &&
                  model.tasksModel.details.data.length > 0
              ? ListView.builder(
                  shrinkWrap: true,
                  itemCount: model.tasksModel.details.data.length ?? 0,
                  itemBuilder: (BuildContext ctx, int index) =>
                      buildItems(ctx, model, index, context))
              : Container(
                  child: Center(
                    child: Text(
                      lang.translate('No task found'),
                      style: TextStyle(
                          color: Theme.of(context).secondaryHeaderColor),
                    ),
                  ),
                ),
    );
  }

  buildItems(BuildContext ctx, AllTasksPageModel model, int index, context) {
    var task = model.tasksModel.details.data[index];
    final lang = Provider.of<GlobalTranslations>(ctx, listen: false);
    return InkWell(
      onTap: () {
        print("tapped");
        if (task.statusRaw == 'inProgress' ||
            task.statusRaw == 'started' ||
            task.statusRaw == 'acknowledged' ||
            task.statusRaw == 'assigned') {
          UI.push(ctx,
              Routes.newDeliveryPage(newTask: Details.fromJson(task.toJson())));
          /*   UI.push(ctx,
              Routes.orderDetailPage(orderId: task.orderId));*/
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Theme.of(context).cardColor),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: 8),
                    Text(lang.translate('DELIVERY #') ?? " ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: kDarkTextColor,
                            fontSize: 14)),
                    Text(
                        model.tasksModel.details.data[index].statusRaw
                                .toUpperCase() ??
                            " ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: statusColor(model
                                .tasksModel.details.data[index].statusRaw))),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                buildRowItem(
                    icon: Icon(MdiIcons.clockOutline),
                    title: lang.translate(
                      "Time",
                    ),
                    value: task.dateCreated),
                buildRowItem(
                    icon: Icon(MdiIcons.fileDocument),
                    title: lang.translate("Task Number"),
                    value: task.taskId),
                buildRowItem(
                    icon: Icon(Icons.person),
                    title: lang.translate("Customer Name"),
                    value: task.customerName),
                buildRowItem(
                    icon: Icon(Icons.flag),
                    title: lang.translate("Delivery Address"),
                    value: task.deliveryAddress),
                buildRowItem(
                    icon: Icon(Icons.store),
                    title: lang.translate("Merchant Name"),
                    value: task.merchantName),
                ExpandChild(
                    child: Column(children: [
                  buildRowItem(
                      icon: Icon(Icons.call),
                      title: lang.translate("Contact Number"),
                      value: task.contactNumber),
                  buildRowItem(
                      icon: Icon(Icons.branding_watermark),
                      title: lang.translate("Order Number"),
                      value: task.orderId),
                  buildRowItem(
                      icon: Icon(MdiIcons.listStatus),
                      title: lang.translate("Order status"),
                      value: task.orderStatus),
                  buildRowItem(
                      icon: Icon(Icons.payment),
                      title: lang.translate("Payment Type"),
                      value: task.paymentType),
                ]))
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color statusColor(status) {
    switch (status) {
      case 'failed':
        return kMainColor;
      case 'cancelled':
        return kDarkTextColor;
      case 'declined':
        return kMainColor;
      case 'acknowledged':
        return Colors.deepPurple;
      case 'started':
        return Colors.blue;
      case 'inProgress':
        return kFloatingButtonColor;
      case 'successful':
        return Colors.deepPurple;
      default:
        return Colors.deepPurple;
    }
  }

  Widget buildRowItem({
    @required String title,
    @required String value,
    @required Widget icon,
  }) {
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
            child: Text(txt ?? " ",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: kHintColor)),
          )
        ],
      ),
    );
  }
}

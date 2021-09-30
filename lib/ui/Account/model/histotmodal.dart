import 'dart:developer';

import 'package:EfendimDriverApp/core/models/new_order.dart';
import 'package:EfendimDriverApp/core/preference/preference.dart';
import 'package:EfendimDriverApp/ui/Account/model/account_page_model.dart';
import 'package:base_notifier/base_notifier.dart';
import 'package:flutter/material.dart';
import 'package:EfendimDriverApp/core/auth/authentication_service.dart';
import 'package:EfendimDriverApp/core/api/http_api.dart';
import 'package:EfendimDriverApp/core/models/all_tasks_model.dart';
import 'package:EfendimDriverApp/core/constants/constants.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'dart:convert';
import 'package:ui_utils/ui_utils.dart';

class HistoryPageModel extends BaseNotifier {
  final HttpApi api;
  final AuthenticationService auth;
  final BuildContext context;
  NewOrderModel newOrderModel;
  bool gettingProfile = false;
  bool gettingProfileError = false;
  String errorMsg = '';
  bool isAccepted = false;
  bool changingOrderStatus = false;
  bool offline = false;
  bool accountstatus = true;
  AllTasksModel tasksModel;
  int selection = 0;
  String errorString;
  List<Meeting> listtask;

  HistoryPageModel({NotifierState state, this.api, this.auth, this.context})
      : super(state: state) {
    var ddd = Preference.getString(PrefKeys.status);

    accountstatus = (ddd != 'active');
    // getProfile();

    getAllTask();
  }
  void getProfile() async {
    await auth.loadUser();
    await changeDutyStatue(isOnline: true);

    gettingProfile = true;
    setState();
    if (await auth.getUserProfile(
      context,
    )) {
      gettingProfile = false;
      setState();
    } else {
      gettingProfile = false;
      gettingProfileError = true;
      setState();
    }
  }

  List<Meeting> getDataSource() {
    // await getAllTask();
    final List<Meeting> meetings = <Meeting>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
        DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    tasksModel.details.data.forEach((element) {
      meetings.add(Meeting(
          "T:${element.taskId}",
          DateTime.parse(element.dateCreated),
          DateTime.parse(element.dateCreated),
          const Color(0xFF0F8644),
          false));
    });
    listtask = meetings;
    return meetings;
  }

  getAllTask() async {
    // selection 0 => Penmding tasks
    // selection 1 => Completed tasks
    //
    setBusy();
    print("selection..$selection");
    final body = {
      'app_version': Constants.APP_VERSION,
      'token': auth.user.details.token,
      'api_key': Constants.API_KEY,
      'lang': Constants.APP_LANGUAGE,
      'task_type': 'pending'
    };
    final res = await api.getAllTasks(context, body: body);
    print(body.toString());
    log("task data..$res");
    res.fold((e) {
      // something error
      errorString = e.toString();
      UI.toast(e.toString());
    }, (data) {
      // convert data to json
      data = json.decode(data);

      if ((data['code'] == 2) && (data['msg'] == "No task for the day")) {
        tasksModel = AllTasksModel.fromJson(data);
        setIdle();
      } else

      // check if code == 2 that means something is error
      if (data['code'] == 2) {
        tasksModel = AllTasksModel.fromJson(data);

        print("errrrr");
        setError();
        errorString = data['msg'];
      } else {
        tasksModel = AllTasksModel.fromJson(data);

        // tasksModel.details.data = AllTasksModel.fromJson(data)
        //  .details
        // .data
        // .where((element) => element.statusRaw == "inprogress");

        // map json to model
        getDataSource();

        setIdle();
      }
    });
  }

  changeStatusOrder({OrderStatus status}) async {
    final body = {
      'app_version': Constants.APP_VERSION,
      'token': auth.user.details.token,
      'api_key': Constants.API_KEY,
      'task_id': newOrderModel.details.taskId,
      'status_raw': status.status
    };

    // setBusy();
    changingOrderStatus = true;
    setState();

    final res = await api.changeOrderStatus(context, body: body);
    res.fold((e) {
      UI.toast(e.toString());
      changingOrderStatus = false;
      setState();
    }, (data) {
      // covert data to json
      data = json.decode(data);

      if (data['msg'] == 'OK') {
        // Changed successfully
        switch (status) {
          case OrderStatus.STARTED:
            isAccepted = true;
            break;

          default:
        }
        getAllTask();
      }
      changingOrderStatus = false;
      setState();
    });
    // setIdle();
  }

  changeDutyStatue({bool isOnline}) async {
    final body = {
      'app_version': Constants.APP_VERSION,
      'token': auth.user.details.token,
      'api_key': Constants.API_KEY,
      'onduty': isOnline ? "1" : "0"
    };
    final res = await api.changeDutyStatus(context, body: body);
    res.fold((e) {
      UI.toast(e.toString());
    }, (data) {
      // covert data to json
      data = json.decode(data);

      if (data['msg'] == 'OK') {
        // Changed successfully
        offline = !isOnline;
      }
      setState();
    });
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].to;
  }

  @override
  String getSubject(int index) {
    return appointments[index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments[index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}

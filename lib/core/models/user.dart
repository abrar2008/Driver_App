class User {
  int code;
  String msg;
  Details details;
  String request;

  User({this.code, this.msg, this.details, this.request});

  User.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    details =
        json['details'] != null ? new Details.fromJson(json['details']) : null;
    request = json['request'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.details != null) {
      data['details'] = this.details.toJson();
    }
    data['request'] = this.request;
    return data;
  }
}

class Details {
  String username;
  String password;
  String remember;
  String todaysDate;
  String todaysDateRaw;
  String onDuty;
  String token;
  String dutyStatus;
  int locationAccuracy;
  int enabledPush;
  String topicNewTask;
  String topicAlert;

  Details(
      {this.username,
      this.password,
      this.remember,
      this.todaysDate,
      this.todaysDateRaw,
      this.onDuty,
      this.token,
      this.dutyStatus,
      this.locationAccuracy,
      this.enabledPush,
      this.topicNewTask,
      this.topicAlert});

  Details.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    remember = json['remember'];
    todaysDate = json['todays_date'];
    todaysDateRaw = json['todays_date_raw'];
    onDuty = json['on_duty'];
    token = json['token'];
    dutyStatus = json['duty_status'];
    locationAccuracy = json['location_accuracy'];
    enabledPush = json['enabled_push'];
    topicNewTask = json['topic_new_task'];
    topicAlert = json['topic_alert'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    data['remember'] = this.remember;
    data['todays_date'] = this.todaysDate;
    data['todays_date_raw'] = this.todaysDateRaw;
    data['on_duty'] = this.onDuty;
    data['token'] = this.token;
    data['duty_status'] = this.dutyStatus;
    data['location_accuracy'] = this.locationAccuracy;
    data['enabled_push'] = this.enabledPush;
    data['topic_new_task'] = this.topicNewTask;
    data['topic_alert'] = this.topicAlert;
    return data;
  }
}

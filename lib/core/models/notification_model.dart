class NotificationModel {
  int code;
  String msg;
  List<Details> details;

  NotificationModel({this.code, this.msg, this.details});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    if (json['details'] != null) {
      details = new List<Details>();
      json['details'].forEach((v) {
        details.add(new Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.details != null) {
      data['details'] = this.details.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Details {
  String pushId;
  String devicePlatform;
  String deviceId;
  String pushTitle;
  String pushMessage;
  String pushType;
  String actions;
  String status;
  String jsonResponse;
  String orderId;
  String driverId;
  String taskId;
  String dateCreated;
  String dateProcess;
  String ipAddress;
  String isRead;
  String bulkId;
  String userType;
  String userId;

  Details(
      {this.pushId,
      this.devicePlatform,
      this.deviceId,
      this.pushTitle,
      this.pushMessage,
      this.pushType,
      this.actions,
      this.status,
      this.jsonResponse,
      this.orderId,
      this.driverId,
      this.taskId,
      this.dateCreated,
      this.dateProcess,
      this.ipAddress,
      this.isRead,
      this.bulkId,
      this.userType,
      this.userId});

  Details.fromJson(Map<String, dynamic> json) {
    pushId = json['push_id'];
    devicePlatform = json['device_platform'];
    deviceId = json['device_id'];
    pushTitle = json['push_title'];
    pushMessage = json['push_message'];
    pushType = json['push_type'];
    actions = json['actions'];
    status = json['status'];
    jsonResponse = json['json_response'];
    orderId = json['order_id'];
    driverId = json['driver_id'];
    taskId = json['task_id'];
    dateCreated = json['date_created'];
    dateProcess = json['date_process'];
    ipAddress = json['ip_address'];
    isRead = json['is_read'];
    bulkId = json['bulk_id'];
    userType = json['user_type'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['push_id'] = this.pushId;
    data['device_platform'] = this.devicePlatform;
    data['device_id'] = this.deviceId;
    data['push_title'] = this.pushTitle;
    data['push_message'] = this.pushMessage;
    data['push_type'] = this.pushType;
    data['actions'] = this.actions;
    data['status'] = this.status;
    data['json_response'] = this.jsonResponse;
    data['order_id'] = this.orderId;
    data['driver_id'] = this.driverId;
    data['task_id'] = this.taskId;
    data['date_created'] = this.dateCreated;
    data['date_process'] = this.dateProcess;
    data['ip_address'] = this.ipAddress;
    data['is_read'] = this.isRead;
    data['bulk_id'] = this.bulkId;
    data['user_type'] = this.userType;
    data['user_id'] = this.userId;
    return data;
  }
}

class AllTasksModel {
  int code;
  dynamic msg;
  Det details;

  AllTasksModel({this.code, this.msg, this.details});

  AllTasksModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    details =
        json['details'] != null ? new Det.fromJson(json['details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['msg'] = this.msg;
    if (this.details != null) {
      data['details'] = this.details.toJson();
    }
    return data;
  }
}

class Det {
  List<Data> data;
  String todaysDateRaw;
  String todaysDate;

  Det({this.data, this.todaysDateRaw, this.todaysDate});

  Det.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    todaysDateRaw = json['todays_date_raw'];
    todaysDate = json['todays_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['todays_date_raw'] = this.todaysDateRaw;
    data['todays_date'] = this.todaysDate;
    return data;
  }
}

class Data {
  String taskId;
  String orderId;
  String userType;
  String userId;
  String taskDescription;
  String transType;
  String contactNumber;
  String emailAddress;
  String customerName;
  String deliveryDate;
  String deliveryAddress;
  String teamId;
  String driverId;
  String taskLat;
  String taskLng;
  String customerSignature;
  String status;
  String dateCreated;
  String dateModified;
  String ipAddress;
  String autoAssignType;
  String assignStarted;
  String assignmentStatus;
  String dropoffMerchant;
  String dropoffContactName;
  String dropoffContactNumber;
  String dropAddress;
  String dropoffLat;
  String dropoffLng;
  String recipientName;
  String critical;
  String rating;
  dynamic ratingComment;
  String ratingAnonymous;
  dynamic dealType;
  String deliveryDateOnly;
  String driverName;
  String deviceId;
  String driverPhone;
  String driverEmail;
  String devicePlatform;
  String enabledPush;
  String driverLat;
  String driverLng;
  String driverPhoto;
  String driverVehicle;
  dynamic merchantId;
  String merchantName;
  String merchantAddress;
  String teamName;
  dynamic totalWTax;
  dynamic deliveryCharge;
  dynamic paymentType;
  dynamic orderStatus;
  dynamic optContactDelivery;
  String deliveryTime;
  String statusRaw;
  String transTypeRaw;
  AllTaskInfo allTaskInfo;

  Data(
      {this.taskId,
      this.orderId,
      this.userType,
      this.userId,
      this.taskDescription,
      this.transType,
      this.contactNumber,
      this.emailAddress,
      this.customerName,
      this.deliveryDate,
      this.deliveryAddress,
      this.teamId,
      this.driverId,
      this.taskLat,
      this.taskLng,
      this.customerSignature,
      this.status,
      this.dateCreated,
      this.dateModified,
      this.ipAddress,
      this.autoAssignType,
      this.assignStarted,
      this.assignmentStatus,
      this.dropoffMerchant,
      this.dropoffContactName,
      this.dropoffContactNumber,
      this.dropAddress,
      this.dropoffLat,
      this.dropoffLng,
      this.recipientName,
      this.critical,
      this.rating,
      this.ratingComment,
      this.ratingAnonymous,
      this.dealType,
      this.deliveryDateOnly,
      this.driverName,
      this.deviceId,
      this.driverPhone,
      this.driverEmail,
      this.devicePlatform,
      this.enabledPush,
      this.driverLat,
      this.driverLng,
      this.driverPhoto,
      this.driverVehicle,
      this.merchantId,
      this.merchantName,
      this.merchantAddress,
      this.teamName,
      this.totalWTax,
      this.deliveryCharge,
      this.paymentType,
      this.orderStatus,
      this.optContactDelivery,
      this.deliveryTime,
      this.statusRaw,
      this.transTypeRaw,
      this.allTaskInfo});

  Data.fromJson(Map<String, dynamic> json) {
    taskId = json['task_id'];
    orderId = json['order_id'];
    userType = json['user_type'];
    userId = json['user_id'];
    taskDescription = json['task_description'];
    transType = json['trans_type'];
    contactNumber = json['contact_number'];
    emailAddress = json['email_address'];
    customerName = json['customer_name'];
    deliveryDate = json['delivery_date'];
    deliveryAddress = json['delivery_address'];
    teamId = json['team_id'];
    driverId = json['driver_id'];
    taskLat = json['task_lat'];
    taskLng = json['task_lng'];
    customerSignature = json['customer_signature'];
    status = json['status'];
    dateCreated = json['date_created'];
    dateModified = json['date_modified'];
    ipAddress = json['ip_address'];
    autoAssignType = json['auto_assign_type'];
    assignStarted = json['assign_started'];
    assignmentStatus = json['assignment_status'];
    dropoffMerchant = json['dropoff_merchant'];
    dropoffContactName = json['dropoff_contact_name'];
    dropoffContactNumber = json['dropoff_contact_number'];
    dropAddress = json['drop_address'];
    dropoffLat = json['dropoff_lat'];
    dropoffLng = json['dropoff_lng'];
    recipientName = json['recipient_name'];
    critical = json['critical'];
    rating = json['rating'];
    ratingComment = json['rating_comment'];
    ratingAnonymous = json['rating_anonymous'];
    dealType = json['deal_type'];
    deliveryDateOnly = json['delivery_date_only'];
    driverName = json['driver_name'];
    deviceId = json['device_id'];
    driverPhone = json['driver_phone'];
    driverEmail = json['driver_email'];
    devicePlatform = json['device_platform'];
    enabledPush = json['enabled_push'];
    driverLat = json['driver_lat'];
    driverLng = json['driver_lng'];
    driverPhoto = json['driver_photo'];
    driverVehicle = json['driver_vehicle'];
    merchantId = json['merchant_id'];
    merchantName = json['merchant_name'];
    merchantAddress = json['merchant_address'];
    teamName = json['team_name'];
    totalWTax = json['total_w_tax'];
    deliveryCharge = json['delivery_charge'];
    paymentType = json['payment_type'];
    orderStatus = json['order_status'];
    optContactDelivery = json['opt_contact_delivery'];
    deliveryTime = json['delivery_time'];
    statusRaw = json['status_raw'];
    //statusRaw = json['status'];

    transTypeRaw = json['trans_type_raw'];
    allTaskInfo = json['all_task_info'] != null
        ? new AllTaskInfo.fromJson(json['all_task_info'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['task_id'] = this.taskId;
    data['order_id'] = this.orderId;
    data['user_type'] = this.userType;
    data['user_id'] = this.userId;
    data['task_description'] = this.taskDescription;
    data['trans_type'] = this.transType;
    data['contact_number'] = this.contactNumber;
    data['email_address'] = this.emailAddress;
    data['customer_name'] = this.customerName;
    data['delivery_date'] = this.deliveryDate;
    data['delivery_address'] = this.deliveryAddress;
    data['team_id'] = this.teamId;
    data['driver_id'] = this.driverId;
    data['task_lat'] = this.taskLat;
    data['task_lng'] = this.taskLng;
    data['customer_signature'] = this.customerSignature;
    data['status'] = this.status;
    data['date_created'] = this.dateCreated;
    data['date_modified'] = this.dateModified;
    data['ip_address'] = this.ipAddress;
    data['auto_assign_type'] = this.autoAssignType;
    data['assign_started'] = this.assignStarted;
    data['assignment_status'] = this.assignmentStatus;
    data['dropoff_merchant'] = this.dropoffMerchant;
    data['dropoff_contact_name'] = this.dropoffContactName;
    data['dropoff_contact_number'] = this.dropoffContactNumber;
    data['drop_address'] = this.dropAddress;
    data['dropoff_lat'] = this.dropoffLat;
    data['dropoff_lng'] = this.dropoffLng;
    data['recipient_name'] = this.recipientName;
    data['critical'] = this.critical;
    data['rating'] = this.rating;
    data['rating_comment'] = this.ratingComment;
    data['rating_anonymous'] = this.ratingAnonymous;
    data['deal_type'] = this.dealType;
    data['delivery_date_only'] = this.deliveryDateOnly;
    data['driver_name'] = this.driverName;
    data['device_id'] = this.deviceId;
    data['driver_phone'] = this.driverPhone;
    data['driver_email'] = this.driverEmail;
    data['device_platform'] = this.devicePlatform;
    data['enabled_push'] = this.enabledPush;
    data['driver_lat'] = this.driverLat;
    data['driver_lng'] = this.driverLng;
    data['driver_photo'] = this.driverPhoto;
    data['driver_vehicle'] = this.driverVehicle;
    data['merchant_id'] = this.merchantId;
    data['merchant_name'] = this.merchantName;
    data['merchant_address'] = this.merchantAddress;
    data['team_name'] = this.teamName;
    data['total_w_tax'] = this.totalWTax;
    data['delivery_charge'] = this.deliveryCharge;
    data['payment_type'] = this.paymentType;
    data['order_status'] = this.orderStatus;
    data['opt_contact_delivery'] = this.optContactDelivery;
    data['delivery_time'] = this.deliveryTime;
    data['status_raw'] = this.statusRaw;
    data['trans_type_raw'] = this.transTypeRaw;
    if (this.allTaskInfo != null) {
      data['all_task_info'] = this.allTaskInfo.toJson();
    }
    return data;
  }
}

class AllTaskInfo {
  String taskId;
  String orderId;
  String userType;
  String userId;
  String taskDescription;
  String transType;
  String contactNumber;
  String emailAddress;
  String customerName;
  String deliveryDate;
  String deliveryAddress;
  String teamId;
  String driverId;
  String taskLat;
  String taskLng;
  String customerSignature;
  String status;
  String dateCreated;
  String dateModified;
  String ipAddress;
  String autoAssignType;
  String assignStarted;
  String assignmentStatus;
  String dropoffMerchant;
  String dropoffContactName;
  String dropoffContactNumber;
  String dropAddress;
  String dropoffLat;
  String dropoffLng;
  String recipientName;
  String critical;
  String rating;
  dynamic ratingComment;
  String ratingAnonymous;
  dynamic dealType;
  String deliveryDateOnly;
  String driverName;
  String deviceId;
  String driverPhone;
  String driverEmail;
  String devicePlatform;
  String enabledPush;
  String driverLat;
  String driverLng;
  String driverPhoto;
  String driverVehicle;
  dynamic merchantId;
  String merchantName;
  String merchantAddress;
  String teamName;
  dynamic totalWTax;
  dynamic deliveryCharge;
  dynamic paymentType;
  dynamic orderStatus;
  dynamic optContactDelivery;
  String deliveryTime;
  String statusRaw;
  String transTypeRaw;

  AllTaskInfo(
      {this.taskId,
      this.orderId,
      this.userType,
      this.userId,
      this.taskDescription,
      this.transType,
      this.contactNumber,
      this.emailAddress,
      this.customerName,
      this.deliveryDate,
      this.deliveryAddress,
      this.teamId,
      this.driverId,
      this.taskLat,
      this.taskLng,
      this.customerSignature,
      this.status,
      this.dateCreated,
      this.dateModified,
      this.ipAddress,
      this.autoAssignType,
      this.assignStarted,
      this.assignmentStatus,
      this.dropoffMerchant,
      this.dropoffContactName,
      this.dropoffContactNumber,
      this.dropAddress,
      this.dropoffLat,
      this.dropoffLng,
      this.recipientName,
      this.critical,
      this.rating,
      this.ratingComment,
      this.ratingAnonymous,
      this.dealType,
      this.deliveryDateOnly,
      this.driverName,
      this.deviceId,
      this.driverPhone,
      this.driverEmail,
      this.devicePlatform,
      this.enabledPush,
      this.driverLat,
      this.driverLng,
      this.driverPhoto,
      this.driverVehicle,
      this.merchantId,
      this.merchantName,
      this.merchantAddress,
      this.teamName,
      this.totalWTax,
      this.deliveryCharge,
      this.paymentType,
      this.orderStatus,
      this.optContactDelivery,
      this.deliveryTime,
      this.statusRaw,
      this.transTypeRaw});

  AllTaskInfo.fromJson(Map<String, dynamic> json) {
    taskId = json['task_id'];
    orderId = json['order_id'];
    userType = json['user_type'];
    userId = json['user_id'];
    taskDescription = json['task_description'];
    transType = json['trans_type'];
    contactNumber = json['contact_number'];
    emailAddress = json['email_address'];
    customerName = json['customer_name'];
    deliveryDate = json['delivery_date'];
    deliveryAddress = json['delivery_address'];
    teamId = json['team_id'];
    driverId = json['driver_id'];
    taskLat = json['task_lat'];
    taskLng = json['task_lng'];
    customerSignature = json['customer_signature'];
    status = json['status'];
    dateCreated = json['date_created'];
    dateModified = json['date_modified'];
    ipAddress = json['ip_address'];
    autoAssignType = json['auto_assign_type'];
    assignStarted = json['assign_started'];
    assignmentStatus = json['assignment_status'];
    dropoffMerchant = json['dropoff_merchant'];
    dropoffContactName = json['dropoff_contact_name'];
    dropoffContactNumber = json['dropoff_contact_number'];
    dropAddress = json['drop_address'];
    dropoffLat = json['dropoff_lat'];
    dropoffLng = json['dropoff_lng'];
    recipientName = json['recipient_name'];
    critical = json['critical'];
    rating = json['rating'];
    ratingComment = json['rating_comment'];
    ratingAnonymous = json['rating_anonymous'];
    dealType = json['deal_type'];
    deliveryDateOnly = json['delivery_date_only'];
    driverName = json['driver_name'];
    deviceId = json['device_id'];
    driverPhone = json['driver_phone'];
    driverEmail = json['driver_email'];
    devicePlatform = json['device_platform'];
    enabledPush = json['enabled_push'];
    driverLat = json['driver_lat'];
    driverLng = json['driver_lng'];
    driverPhoto = json['driver_photo'];
    driverVehicle = json['driver_vehicle'];
    merchantId = json['merchant_id'];
    merchantName = json['merchant_name'];
    merchantAddress = json['merchant_address'];
    teamName = json['team_name'];
    totalWTax = json['total_w_tax'];
    deliveryCharge = json['delivery_charge'];
    paymentType = json['payment_type'];
    orderStatus = json['order_status'];
    optContactDelivery = json['opt_contact_delivery'];
    deliveryTime = json['delivery_time'];
    statusRaw = json['status_raw'];
    transTypeRaw = json['trans_type_raw'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['task_id'] = this.taskId;
    data['order_id'] = this.orderId;
    data['user_type'] = this.userType;
    data['user_id'] = this.userId;
    data['task_description'] = this.taskDescription;
    data['trans_type'] = this.transType;
    data['contact_number'] = this.contactNumber;
    data['email_address'] = this.emailAddress;
    data['customer_name'] = this.customerName;
    data['delivery_date'] = this.deliveryDate;
    data['delivery_address'] = this.deliveryAddress;
    data['team_id'] = this.teamId;
    data['driver_id'] = this.driverId;
    data['task_lat'] = this.taskLat;
    data['task_lng'] = this.taskLng;
    data['customer_signature'] = this.customerSignature;
    data['status'] = this.status;
    data['date_created'] = this.dateCreated;
    data['date_modified'] = this.dateModified;
    data['ip_address'] = this.ipAddress;
    data['auto_assign_type'] = this.autoAssignType;
    data['assign_started'] = this.assignStarted;
    data['assignment_status'] = this.assignmentStatus;
    data['dropoff_merchant'] = this.dropoffMerchant;
    data['dropoff_contact_name'] = this.dropoffContactName;
    data['dropoff_contact_number'] = this.dropoffContactNumber;
    data['drop_address'] = this.dropAddress;
    data['dropoff_lat'] = this.dropoffLat;
    data['dropoff_lng'] = this.dropoffLng;
    data['recipient_name'] = this.recipientName;
    data['critical'] = this.critical;
    data['rating'] = this.rating;
    data['rating_comment'] = this.ratingComment;
    data['rating_anonymous'] = this.ratingAnonymous;
    data['deal_type'] = this.dealType;
    data['delivery_date_only'] = this.deliveryDateOnly;
    data['driver_name'] = this.driverName;
    data['device_id'] = this.deviceId;
    data['driver_phone'] = this.driverPhone;
    data['driver_email'] = this.driverEmail;
    data['device_platform'] = this.devicePlatform;
    data['enabled_push'] = this.enabledPush;
    data['driver_lat'] = this.driverLat;
    data['driver_lng'] = this.driverLng;
    data['driver_photo'] = this.driverPhoto;
    data['driver_vehicle'] = this.driverVehicle;
    data['merchant_id'] = this.merchantId;
    data['merchant_name'] = this.merchantName;
    data['merchant_address'] = this.merchantAddress;
    data['team_name'] = this.teamName;
    data['total_w_tax'] = this.totalWTax;
    data['delivery_charge'] = this.deliveryCharge;
    data['payment_type'] = this.paymentType;
    data['order_status'] = this.orderStatus;
    data['opt_contact_delivery'] = this.optContactDelivery;
    data['delivery_time'] = this.deliveryTime;
    data['status_raw'] = this.statusRaw;
    data['trans_type_raw'] = this.transTypeRaw;
    return data;
  }
}

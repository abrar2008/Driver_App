class NewOrderModel {
  int code;
  String msg;
  Details details;

  NewOrderModel({this.code, this.msg, this.details});

  NewOrderModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    msg = json['msg'];
    details =
        json['details'] != null ? new Details.fromJson(json['details']) : null;
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

class Details {
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
  dynamic distance;
  dynamic deliveryBy;
  String teamLeader;
  String partner;
  String merchantName;
  String merchantAddress;
  dynamic receiveFromCustomer;
  dynamic payToMerchant;
  dynamic driverRevenue;
  dynamic adminRevenue;
  String adminRevenueStatus;

  Details(
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
      this.distance,
      this.deliveryBy,
      this.teamLeader,
      this.partner,
      this.receiveFromCustomer,
      this.payToMerchant,
      this.merchantAddress,
      this.driverRevenue,
      this.adminRevenue,
      this.merchantName,
      this.adminRevenueStatus});

  Details.fromJson(Map<String, dynamic> json) {
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
    merchantName = json['merchant_name'];
    dateCreated = json['date_created'];
    dateModified = json['date_modified'];
    ipAddress = json['ip_address'];
    autoAssignType = json['auto_assign_type'];
    assignStarted = json['assign_started'];
    merchantAddress = json['merchant_address'];
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
    distance = json['distance'];
    deliveryBy = json['delivery_by'];
    teamLeader = json['team_leader'];
    partner = json['partner'];
    // receiveFromCustomer = json['receive_from_customer'];
    // payToMerchant = json['pay_to_merchant'];
    // driverRevenue = json['driver_revenue'];
    // adminRevenue = json['admin_revenue'];
    adminRevenueStatus = json['admin_revenue_status'];
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
    data['merchantAddress'] = this.merchantAddress;
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
    data['distance'] = this.distance;
    data['delivery_by'] = this.deliveryBy;
    data['team_leader'] = this.teamLeader;
    data['partner'] = this.partner;
    // data['receive_from_customer'] = this.receiveFromCustomer;
    // data['pay_to_merchant'] = this.payToMerchant;
    // data['driver_revenue'] = this.driverRevenue;
    // data['admin_revenue'] = this.adminRevenue;
    data['admin_revenue_status'] = this.adminRevenueStatus;
    return data;
  }
}

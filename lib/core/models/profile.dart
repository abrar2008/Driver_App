class Profile {
  int code;
  String msg;
  Details details;

  Profile({this.code, this.msg, this.details});

  Profile.fromJson(Map<String, dynamic> json) {
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
  String fullName;
  String teamName;
  String email;
  String phone;
  String transportTypeId;
  String transportTypeId2;
  String transportDescription;
  String licencePlate;
  String color;
  String profilePhoto;
  TransportList transportList;
  int totalDistance;
  int totalTask;
  String driverCommission;
  String driverInitialCommission;
  int countComment;
  int driverBalance;
  int sumDriverRevenue;
  int driverReview;
  int balance;

  Details(
      {this.fullName,
      this.teamName,
      this.email,
      this.phone,
      this.transportTypeId,
      this.transportTypeId2,
      this.transportDescription,
      this.licencePlate,
      this.color,
      this.profilePhoto,
      this.transportList,
      this.totalDistance,
      this.totalTask,
      this.driverCommission,
      this.driverInitialCommission,
      this.countComment,
      this.driverBalance,
      this.sumDriverRevenue,
      this.driverReview,
      this.balance});

  Details.fromJson(Map<String, dynamic> json) {
    fullName = json['full_name'];
    teamName = json['team_name'];
    email = json['email'];
    phone = json['phone'];
    transportTypeId = json['transport_type_id'];
    transportTypeId2 = json['transport_type_id2'];
    transportDescription = json['transport_description'];
    licencePlate = json['licence_plate'];
    color = json['color'];
    profilePhoto = json['profile_photo'];
    transportList = json['transport_list'] != null
        ? new TransportList.fromJson(json['transport_list'])
        : null;
    totalDistance = json['total_distance'];
    totalTask = json['total_task'];
    driverCommission = json['driver_commission'];
    driverInitialCommission = json['driver_initial_commission'];
    countComment = json['count_comment'];
    driverBalance = json['driver_balance'];
    sumDriverRevenue = json['sum_driver_revenue'];
    driverReview = json['driver_review'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['full_name'] = this.fullName;
    data['team_name'] = this.teamName;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['transport_type_id'] = this.transportTypeId;
    data['transport_type_id2'] = this.transportTypeId2;
    data['transport_description'] = this.transportDescription;
    data['licence_plate'] = this.licencePlate;
    data['color'] = this.color;
    data['profile_photo'] = this.profilePhoto;
    if (this.transportList != null) {
      data['transport_list'] = this.transportList.toJson();
    }
    data['total_distance'] = this.totalDistance;
    data['total_task'] = this.totalTask;
    data['driver_commission'] = this.driverCommission;
    data['driver_initial_commission'] = this.driverInitialCommission;
    data['count_comment'] = this.countComment;
    data['driver_balance'] = this.driverBalance;
    data['sum_driver_revenue'] = this.sumDriverRevenue;
    data['driver_review'] = this.driverReview;
    data['balance'] = this.balance;
    return data;
  }
}

class TransportList {
  String a;
  String truck;
  String car;
  String bike;
  String bicycle;
  String scooter;
  String walk;

  TransportList(
      {this.a,
      this.truck,
      this.car,
      this.bike,
      this.bicycle,
      this.scooter,
      this.walk});

  TransportList.fromJson(Map<String, dynamic> json) {
    // a = json['a'];
    truck = json['truck'];
    car = json['car'];
    bike = json['bike'];
    bicycle = json['bicycle'];
    scooter = json['scooter'];
    walk = json['walk'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['a'] = this.a;
    data['truck'] = this.truck;
    data['car'] = this.car;
    data['bike'] = this.bike;
    data['bicycle'] = this.bicycle;
    data['scooter'] = this.scooter;
    data['walk'] = this.walk;
    return data;
  }
}

class TransportVehicle {
  int code;
  String msg;
  Details details;

  TransportVehicle({this.code, this.msg, this.details});

  TransportVehicle.fromJson(Map<String, dynamic> json) {
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
  String a;
  String truck;
  String car;
  String bike;
  String bicycle;
  String scooter;
  String walk;

  Details(
      {this.a,
      this.truck,
      this.car,
      this.bike,
      this.bicycle,
      this.scooter,
      this.walk});

  Details.fromJson(Map<String, dynamic> json) {
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

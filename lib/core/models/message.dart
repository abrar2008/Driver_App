class Message {
  int time;
  String image;
  String content;
  String sId;
  Sender sender;
  Sender reciever;
  int iV;

  Message(
      {this.time,
      this.image,
      this.content,
      this.sId,
      this.sender,
      this.reciever,
      this.iV});

  Message.fromJson(Map<String, dynamic> json) {
    time = json['time'];
    image = json['image'];
    content = json['content'];
    sId = json['_id'];
    sender =
        json['sender'] != null ? new Sender.fromJson(json['sender']) : null;
    reciever =
        json['reciever'] != null ? new Sender.fromJson(json['reciever']) : null;
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['time'] = this.time;
    data['image'] = this.image;
    data['content'] = this.content;
    data['_id'] = this.sId;
    if (this.sender != null) {
      data['sender'] = this.sender.toJson();
    }
    if (this.reciever != null) {
      data['reciever'] = this.reciever.toJson();
    }
    data['__v'] = this.iV;
    return data;
  }
}

class Sender {
  String userType;
  String avatar;
  String sId;
  String name;

  Sender({this.userType, this.avatar, this.sId, this.name});

  Sender.fromJson(Map<String, dynamic> json) {
    userType = json['userType'];
    avatar = json['avatar'];
    sId = json['_id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userType'] = this.userType;
    data['avatar'] = this.avatar;
    data['_id'] = this.sId;
    data['name'] = this.name;
    return data;
  }
}

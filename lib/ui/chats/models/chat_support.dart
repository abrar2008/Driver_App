import 'package:cloud_firestore/cloud_firestore.dart';

import 'chat_message.dart';
import 'package:meta/meta.dart';

class ChatSupport {
  String id;
  String userName;
  String userEmail;
  String userPhone;
  UserType userType;
  ChatSupportStatus status;

  // only have a value when the support is related to a order
  String orderId;

  DateTime createdAt;
  DateTime lastSeenAdmin;
  DateTime lastSeenUser;

  ChatSupport({
    this.createdAt,
    this.orderId,
    this.lastSeenAdmin,
    this.lastSeenUser,
    this.id,
    this.userEmail,
    this.status,
    @required this.userName,
    @required this.userPhone,
    @required this.userType,
  });

  factory ChatSupport.fromJson(Map<String, dynamic> data) {
    DateTime lastSeenUser;
    if (data['lastSeenUser'] != null) {
      lastSeenUser = data['lastSeenUser'].toDate();
    }

    DateTime lastSeenAdmin;
    if (data['lastSeenAdmin'] != null) {
      lastSeenAdmin = data['lastSeenAdmin'].toDate();
    }

    return ChatSupport(
      createdAt: data['createdAt'].toDate(),
      lastSeenUser: lastSeenUser,
      lastSeenAdmin: lastSeenAdmin,
      userEmail: data['userEmail'],
      userName: data['userName'],
      userPhone: data['userPhone'],
      userType: UserType.values[data['userType']],
      status: ChatSupportStatus.values[data['status']],
      orderId: data['orderId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userEmail': this.userEmail,
      'userName': this.userName,
      'userPhone': this.userPhone,
      'userType': this.userType.index,
      'createdAt': Timestamp.now(),
      'status': ChatSupportStatus.pending.index,
      'lastSeenUser':
          lastSeenUser != null ? Timestamp.fromDate(this.lastSeenUser) : null,
      'lastSeenAdmin':
          lastSeenAdmin != null ? Timestamp.fromDate(this.lastSeenAdmin) : null,
      if (orderId != null) 'orderId': this.orderId,
    };
  }
}

enum ChatSupportStatus { pending, assigned, finished }

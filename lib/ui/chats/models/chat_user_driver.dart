import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class ChatUserDriver {
  static const String userNotificationTokenField = 'userNotificationToken';
  static const String driverNotificationTokenField = 'driverNotificationToken';
  static const String newMessagesUserField = 'newMessagesUser';
  static const String newMessagesDriverField = 'newMessagesDriver';

  String orderId;
  DateTime createdAt;
  DateTime lastSeenUser;
  DateTime lastSeenDriver;

  String userNotificationToken;
  String driverNotificationToken;
  int newMessagesUser;
  int newMessagesDriver;

  ChatUserDriver({
    @required this.orderId,
    this.createdAt,
    this.lastSeenDriver,
    this.lastSeenUser,
    this.userNotificationToken,
    this.driverNotificationToken,
    this.newMessagesDriver,
    this.newMessagesUser,
  });

  factory ChatUserDriver.fromJson(Map<String, dynamic> data) {
    DateTime lastSeenUser;
    if (data['lastSeenUser'] != null) {
      lastSeenUser = data['lastSeenUser'].toDate();
    }

    DateTime lastSeenDriver;
    if (data['lastSeenDriver'] != null) {
      lastSeenDriver = data['lastSeenDriver'].toDate();
    }

    return ChatUserDriver(
      createdAt: data['createdAt'].toDate(),
      lastSeenUser: lastSeenUser,
      lastSeenDriver: lastSeenDriver,
      newMessagesDriver: data[newMessagesDriverField] ?? 0,
      newMessagesUser: data[newMessagesUserField] ?? 0,
      userNotificationToken: data[userNotificationTokenField],
      driverNotificationToken: data[driverNotificationTokenField],
      orderId: data['orderId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': Timestamp.now(),
      userNotificationTokenField: this.userNotificationToken,
      driverNotificationTokenField: this.driverNotificationToken,
      newMessagesDriverField: 0,
      newMessagesUserField: 0,
      'lastSeenUser':
          lastSeenUser != null ? Timestamp.fromDate(this.lastSeenUser) : null,
      'lastSeenDriver': lastSeenDriver != null
          ? Timestamp.fromDate(this.lastSeenDriver)
          : null,
    };
  }
}

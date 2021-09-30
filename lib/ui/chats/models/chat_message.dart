import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class ChatMessage {
  String id;
  UserType userType;
  String message;
  DateTime createdAt;
  bool isLocation;

  ChatMessage({
    @required this.userType,
    @required this.createdAt,
    this.isLocation = false,
    this.message,
    this.id,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> data) {
    return ChatMessage(
      userType: UserType.values[data['userType']],
      message: data['message'],
      createdAt: data['createdAt'].toDate(),
      isLocation: data['isLocation'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userType': this.userType.index,
      'message': this.message,
      'isLocation': this.isLocation,
      'createdAt': Timestamp.fromDate(this.createdAt),
    };
  }
}

enum UserType { admin, user, merchant, driver, guest }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class SupportChat {
  static const hasNewAdminMessageField = 'hasNewAdminMessage';
  static const hasNewGuestMessageField = 'hasNewGuestMessage';

  String id;
  bool hasNewGuestMessage;
  bool hasNewAdminMessage;
  DateTime createdAt;
  String userName;
  String userPhone;
  String userEmail;

  SupportChat({
    @required this.userName,
    @required this.userPhone,
    this.id,
    this.hasNewAdminMessage = false,
    this.hasNewGuestMessage = false,
    this.createdAt,
    this.userEmail,
  });

  factory SupportChat.fromJson(Map<String, dynamic> data) {
    return SupportChat(
      hasNewAdminMessage: data[hasNewAdminMessageField] ?? false,
      hasNewGuestMessage: data[hasNewGuestMessageField] ?? true,
      userName: data['userName'],
      userEmail: data['userEmail'],
      userPhone: data['userPhone'],
      createdAt: data['createdAt'].toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': this.userName,
      'userEmail': this.userEmail,
      'userPhone': this.userPhone,
      'hasNewAdminMessage': this.hasNewAdminMessage,
      'hasNewGuestMessage': this.hasNewGuestMessage,
      'createdAt': Timestamp.now(),
    };
  }
}

class SupportMessage {
  String id;
  DateTime createdAt;
  String message;
  bool isLocation;
  bool isAdminResponse;

  SupportMessage({
    @required this.message,
    this.isAdminResponse = false,
    this.isLocation = false,
    this.createdAt,
    this.id,
  });

  factory SupportMessage.fromJson(Map<String, dynamic> data) {
    return SupportMessage(
      message: data['message'],
      createdAt: data['createdAt'].toDate(),
      isLocation: data['isLocation'] ?? false,
      isAdminResponse: data['isAdminResponse'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': this.message.trim(),
      'createdAt': Timestamp.now(),
      'isLocation': this.isLocation,
      'isAdminResponse': this.isAdminResponse,
    };
  }
}

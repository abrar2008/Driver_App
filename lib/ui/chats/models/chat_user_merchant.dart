import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class ChatUserMerchant {
  String orderId;
  DateTime createdAt;
  DateTime lastSeenUser;
  DateTime lastSeenMerchant;

  ChatUserMerchant({
    @required this.createdAt,
    this.orderId,
    this.lastSeenMerchant,
    this.lastSeenUser,
  });

  factory ChatUserMerchant.fromJson(Map<String, dynamic> data) {
    DateTime lastSeenUser;
    if (data['lastSeenUser'] != null) {
      lastSeenUser = data['lastSeenUser'].toDate();
    }

    DateTime lastSeenMerchant;
    if (data['lastSeenMerchant'] != null) {
      lastSeenMerchant = data['lastSeenMerchant'].toDate();
    }

    return ChatUserMerchant(
      createdAt: data['createdAt'].toDate(),
      lastSeenUser: lastSeenUser,
      lastSeenMerchant: lastSeenMerchant,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': this.createdAt,
      if (lastSeenUser != null)
        'lastSeenUser': Timestamp.fromDate(this.lastSeenUser),
      if (lastSeenMerchant != null)
        'lastSeenMerchant': Timestamp.fromDate(this.lastSeenMerchant),
    };
  }
}

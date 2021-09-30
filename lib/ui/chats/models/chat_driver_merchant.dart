import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class ChatDriverMerchant {
  String orderId;
  DateTime createdAt;
  DateTime lastSeenDriver;
  DateTime lastSeenMerchant;

  ChatDriverMerchant({
    @required this.createdAt,
    this.orderId,
    this.lastSeenMerchant,
    this.lastSeenDriver,
  });

  factory ChatDriverMerchant.fromJson(Map<String, dynamic> data) {
    DateTime lastSeenDriver;
    if (data['lastSeenDriver'] != null) {
      lastSeenDriver = data['lastSeenDriver'].toDate();
    }

    DateTime lastSeenMerchant;
    if (data['lastSeenMerchant'] != null) {
      lastSeenMerchant = data['lastSeenMerchant'].toDate();
    }

    return ChatDriverMerchant(
      createdAt: data['createdAt'].toDate(),
      lastSeenDriver: lastSeenDriver,
      lastSeenMerchant: lastSeenMerchant,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': this.createdAt,
      if (lastSeenDriver != null)
        'lastSeenDriver': Timestamp.fromDate(this.lastSeenDriver),
      if (lastSeenMerchant != null)
        'lastSeenMerchant': Timestamp.fromDate(this.lastSeenMerchant),
    };
  }
}

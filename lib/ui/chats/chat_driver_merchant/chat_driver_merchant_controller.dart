import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/chat_driver_merchant.dart';
import '../models/chat_message.dart';

class ChatDriverMerchantController extends GetxController {
  static ChatDriverMerchantController get to => Get.find();

  TextEditingController messageController = TextEditingController();

  ChatDriverMerchantParams params = Get.arguments;

  final _rxMessage = Rx<String>('');
  String get message => _rxMessage.value;
  set message(String value) => _rxMessage.value = value;

  final _rxChat = Rx<ChatDriverMerchant>(null);
  ChatDriverMerchant get chat => _rxChat.value;
  set chat(ChatDriverMerchant value) => _rxChat.value = value;

  CollectionReference get messagesCollection => FirebaseFirestore.instance
      .collection("chats_driver_merchant")
      .doc(params.orderId)
      .collection("messages");

  DocumentReference get chatDocument => FirebaseFirestore.instance
      .collection("chats_driver_merchant")
      .doc(params.orderId);

  @override
  void onInit() {
    super.onInit();
    init();
  }

  Future<void> init() async {
    chatDocument.update({'lastSeenDriver': Timestamp.now()});
  }

  void sendMessage() async {
    ChatMessage message = ChatMessage(
      message: this.message,
      createdAt: DateTime.now(),
      userType: UserType.driver,
      isLocation: false,
    );

    CollectionReference messages = messagesCollection;
    messages.add(message.toJson());

    this.message = '';
    messageController.clear();
  }

  Stream<List<ChatMessage>> messagesSnapshot() {
    return messagesCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((event) => event.docs.map((e) {
              ChatMessage message = ChatMessage.fromJson(e.data());
              message.id = e.id;
              return message;
            }).toList());
  }

  void openContactNumber() {
    String url = 'tel://${params.merchantPhone}';
    launch(url);
  }
}

class ChatDriverMerchantParams {
  String orderId;
  String merchantPhone;

  ChatDriverMerchantParams({
    @required this.orderId,
    @required this.merchantPhone,
  });
}

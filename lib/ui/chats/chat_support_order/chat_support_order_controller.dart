import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../core/auth/authentication_service.dart';
import '../../../core/models/profile.dart';
import '../models/chat_message.dart';
import '../models/chat_support.dart';

class ChatSupportOrderController extends GetxController {
  static ChatSupportOrderController get to => Get.find();

  TextEditingController messageController = TextEditingController();

  String orderId = Get.arguments;

  final _rxLoading = Rx<bool>(true);
  bool get loading => _rxLoading.value;
  set loading(bool value) => _rxLoading.value = value;

  final _rxMessage = Rx<String>('');
  String get message => _rxMessage.value;
  set message(String value) => _rxMessage.value = value;

  final _rxChat = Rx<ChatSupport>(null);
  ChatSupport get chat => _rxChat.value;
  set chat(ChatSupport value) => _rxChat.value = value;

  CollectionReference get messagesCollection => FirebaseFirestore.instance
      .collection("chats_support_order")
      .doc(chat?.id)
      .collection("messages");

  DocumentReference get chatDocument => FirebaseFirestore.instance
      .collection("chats_support_order")
      .doc(chat?.id);

  @override
  void onInit() {
    super.onInit();
    init();
  }

  Future<void> init() async {
    this.loading = true;
    DocumentReference chat = messagesCollection.parent;

    final AuthenticationService auth =
        Provider.of<AuthenticationService>(Get.context, listen: false);

    Profile profile = auth.userProfile;
    this.chat = ChatSupport(
      id: chat.id,
      userName: profile.details.fullName,
      userPhone: profile.details.phone,
      userEmail: profile.details.email,
      lastSeenUser: DateTime.now(),
      userType: UserType.driver,
      orderId: this.orderId,
    );

    await chat.set(this.chat.toJson());
    this.loading = false;
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
}

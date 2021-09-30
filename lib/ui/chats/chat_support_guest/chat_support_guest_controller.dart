import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/chat_message.dart';
import '../models/chat_support.dart';

class ChatSupportGuestController extends GetxController {
  static ChatSupportGuestController get to => Get.find();

  ChatSupportGuestParams params = Get.arguments;
  UserType userType = UserType.driver;

  TextEditingController messageController = TextEditingController();

  final _rxChat = Rx<ChatSupport>(null);
  ChatSupport get chat => _rxChat.value;
  set chat(ChatSupport value) => _rxChat.value = value;

  final _rxMessage = Rx<String>('');
  String get message => _rxMessage.value;
  set message(String value) => _rxMessage.value = value;

  final _rxLoading = Rx<bool>(true);
  bool get loading => _rxLoading.value;
  set loading(bool value) => _rxLoading.value = value;

  CollectionReference get messagesCollection => FirebaseFirestore.instance
      .collection("chats_support_guest")
      .doc(chat?.id)
      .collection("messages");

  @override
  void onInit() {
    super.onInit();
    createChat();
  }

  Future<void> createChat() async {
    this.loading = true;
    DocumentReference chat = messagesCollection.parent;

    this.chat = ChatSupport(
      id: chat.id,
      userName: params.name,
      userPhone: params.phone,
      userEmail: params.email,
      userType: userType,
      lastSeenUser: DateTime.now(),
    );

    await chat.set(this.chat.toJson());
    this.loading = false;
  }

  void sendMessage() async {
    ChatMessage message = ChatMessage(
      message: this.message,
      createdAt: DateTime.now(),
      userType: userType,
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

  void showLocation(ChatMessage message) {
    String latLng = message.message.split('|')[1];
    String url = 'https://www.google.com/maps/search/?api=1&query=$latLng';
    launch(url);
  }
}

class ChatSupportGuestParams {
  String name;
  String phone;
  String email;

  ChatSupportGuestParams({
    @required this.name,
    @required this.phone,
    this.email,
  });
}

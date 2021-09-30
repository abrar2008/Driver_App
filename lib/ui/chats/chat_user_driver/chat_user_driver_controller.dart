import 'package:EfendimDriverApp/ui/chats/utils/chat_notification.dart';
import 'package:EfendimDriverApp/ui/chats/utils/chat_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/chat_message.dart';
import '../models/chat_user_driver.dart';

class ChatUserDriverController extends GetxController {
  static ChatUserDriverController get to => Get.find();

  TextEditingController messageController = TextEditingController();

  ChatUserDriverParams params = Get.arguments;

  final _rxMessage = Rx<String>('');
  String get message => _rxMessage.value;
  set message(String value) => _rxMessage.value = value;

  final _rxChat = Rx<ChatUserDriver>(null);
  ChatUserDriver get chat => _rxChat.value;
  set chat(ChatUserDriver value) => _rxChat.value = value;

  final _rxLoading = Rx<bool>(true);
  bool get loading => _rxLoading.value;
  set loading(bool value) => _rxLoading.value = value;

  CollectionReference get messagesCollection => FirebaseFirestore.instance
      .collection("chats_user_driver")
      .doc(params.orderId)
      .collection("messages");

  DocumentReference get chatDocument => FirebaseFirestore.instance
      .collection("chats_user_driver")
      .doc(params.orderId);

  @override
  void onInit() {
    super.onInit();
    init();
  }

  Future<void> init() async {
    loading = true;

    String notificationToken = await getNotificationToken();
    await chatDocument.update({
      ChatUserDriver.newMessagesUserField: 0,
      ChatUserDriver.driverNotificationTokenField: notificationToken,
      'lastSeenDriver': Timestamp.now(),
    }).catchError((_) => null);

    final chat = await chatDocument.get();
    if (chat.exists) {
      this.chat = ChatUserDriver.fromJson(chat.data());
    }

    loading = false;
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

  Future<void> createChat() async {
    final chat = await chatDocument.get();
    if (chat.exists) {
      this.chat = ChatUserDriver.fromJson(chat.data());
      return;
    }

    String notificationToken = await getNotificationToken();
    final newChat = ChatUserDriver(
      orderId: params.orderId,
      driverNotificationToken: notificationToken,
      lastSeenDriver: DateTime.now(),
    );

    await chatDocument.set(newChat.toJson());
    this.chat = newChat;
  }

  void sendText() async {
    ChatMessage message = ChatMessage(
      message: this.message,
      createdAt: DateTime.now(),
      userType: UserType.driver,
      isLocation: false,
    );

    await _sendMessage(message);

    this.message = '';
    messageController.clear();
  }

  Future<void> _sendMessage(ChatMessage message) async {
    if (chat == null) {
      await createChat();
    }

    CollectionReference messages = messagesCollection;
    messages.add(message.toJson());

    chatDocument.update({
      ChatUserDriver.newMessagesDriverField: FieldValue.increment(1),
    });

    if (chat.userNotificationToken != null)
      sendNotification(
        title: 'New messages from driver, order #${params.orderId}',
        message: message.message,
        notificationToken: chat.userNotificationToken,
      );
  }

  void openContactNumber() {
    String url = 'tel://${params.userPhone}';
    launch(url);
  }
}

class ChatUserDriverParams {
  String orderId;
  String userPhone;

  ChatUserDriverParams({
    @required this.orderId,
    @required this.userPhone,
  });
}

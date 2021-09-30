import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/chat_message.dart';
import '../widgets/message_field.dart';
import '../widgets/message_widget.dart';
import 'chat_support_guest_controller.dart';

class ChatSupportGuestPage extends StatefulWidget {
  @override
  _ChatSupportGuestPageState createState() => _ChatSupportGuestPageState();
}

class _ChatSupportGuestPageState extends State<ChatSupportGuestPage> {
  final ChatSupportGuestController controller =
      Get.put(ChatSupportGuestController());

  @override
  void dispose() {
    Get.delete<ChatSupportGuestController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.focusScope.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Support'),
        ),
        body: Obx(() {
          if (controller.loading)
            return Center(
              child: CircularProgressIndicator(),
            );

          return StreamBuilder(
            stream: controller.messagesSnapshot(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                print('load messages error: ${snapshot.error}');
                return Center(child: Text('Error loading chat'));
              }

              if (snapshot.hasData) {
                return Column(
                  children: [
                    Expanded(child: _buildMessagesList(snapshot.data)),
                    SizedBox(height: 10),
                    _buildMessageField(),
                  ],
                );
              }

              return Center(child: CircularProgressIndicator());
            },
          );
        }),
      ),
    );
  }

  Widget _buildMessagesList(List<ChatMessage> messages) {
    return Stack(
      children: [
        Center(
          child: Container(
            child: Opacity(
              opacity: 0.2,
              child: Image.asset(
                'assets/icons/chat_support.png',
                // fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        ListView.separated(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          itemCount: messages.length,
          itemBuilder: (context, index) => _buildMessage(messages[index]),
          separatorBuilder: (context, index) => SizedBox(height: 10),
          reverse: true,
        ),
      ],
    );
  }

  Widget _buildMessageField() {
    return Obx(() {
      return MessageField(
        messageController: controller.messageController,
        onSendMessage: controller.sendMessage,
        onChangeMessage: (value) => controller.message = value,
        sendButtonEnabled: controller.message.isNotEmpty,
      );
    });
  }

  Widget _buildMessage(ChatMessage message) {
    return MessageWidget(
      message: message,
      isMine: message.userType == controller.userType,
    );
  }
}

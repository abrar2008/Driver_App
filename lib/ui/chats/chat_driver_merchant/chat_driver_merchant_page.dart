import 'package:EfendimDriverApp/ui/chats/widgets/chat_header.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/chat_message.dart';
import '../widgets/message_field.dart';
import '../widgets/message_widget.dart';
import 'chat_driver_merchant_controller.dart';

class ChatDriverMerchantPage extends StatefulWidget {
  @override
  _ChatDriverMerchantPageState createState() => _ChatDriverMerchantPageState();
}

class _ChatDriverMerchantPageState extends State<ChatDriverMerchantPage> {
  final ChatDriverMerchantController controller =
      Get.put(ChatDriverMerchantController());

  @override
  void dispose() {
    Get.delete<ChatDriverMerchantController>();
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
          title: ChatHeader(
            title: 'Merchant | Order #${controller.params.orderId}',
          ),
          actions: [
            IconButton(
              onPressed: controller.openContactNumber,
              icon: Icon(Icons.phone),
            )
          ],
        ),
        body: StreamBuilder(
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
        ),
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
                'assets/icons/chat_merchant.png',
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
      isMine: message.userType == UserType.driver,
    );
  }
}

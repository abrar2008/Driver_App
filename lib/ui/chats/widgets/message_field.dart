import 'package:flutter/material.dart';

class MessageField extends StatelessWidget {
  final TextEditingController messageController;
  final bool sendButtonEnabled;
  final void Function(String) onChangeMessage;
  final void Function() onSendMessage;

  MessageField({
    @required this.messageController,
    @required this.onSendMessage,
    this.onChangeMessage,
    this.sendButtonEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10).copyWith(bottom: 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              onChanged: onChangeMessage,
              maxLines: 3,
              minLines: 1,
              decoration: InputDecoration(
                hintText: "Write a message ...",
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 20,
                ),
                border: InputBorder.none,
                hintStyle: TextStyle(
                  color: Colors.grey.withOpacity(0.6),
                  fontWeight: FontWeight.w600,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 0.5),
                  borderRadius: BorderRadius.circular(25),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey, width: 0.5),
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ),
          IconButton(
            onPressed: sendButtonEnabled ? onSendMessage : null,
            icon: Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}

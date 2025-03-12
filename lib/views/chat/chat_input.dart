import 'dart:io';

import 'package:flutter/material.dart';

class MessageInputField extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSendMessage;

  const MessageInputField({super.key, required this.controller, required this.onSendMessage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(hintText: '输入消息...', alignLabelWithHint: true),
              maxLines: 6,
              minLines: 1,
              keyboardType: TextInputType.multiline,
              textInputAction: Platform.isWindows ? TextInputAction.send : TextInputAction.newline, // Send Message
              onSubmitted: (value) {
                // Enter for send
                if (value.trim().isNotEmpty) {
                  onSendMessage();
                  controller.clear();
                  FocusScope.of(context).requestFocus(FocusNode());
                }
              },
              autofocus: true,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send),
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                onSendMessage();
                controller.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}

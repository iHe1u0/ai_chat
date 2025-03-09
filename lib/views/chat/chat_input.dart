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
              decoration: const InputDecoration(
                hintText: '输入消息...',
                alignLabelWithHint: true, // 可选：确保提示文本与输入文本对齐
              ),
              maxLines: 6, // 设置最大行数
              minLines: 1, // 设置最小行数
              keyboardType: TextInputType.multiline, // 确保可以输入多行文本
              textInputAction: TextInputAction.newline, // 支持换行
            ),
          ),
          IconButton(icon: const Icon(Icons.send), onPressed: onSendMessage),
        ],
      ),
    );
  }
}

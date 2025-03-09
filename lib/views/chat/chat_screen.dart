import 'package:chat/models/message.dart';
import 'package:chat/views/chat/chat_input.dart' show MessageInputField;
import 'package:flutter/material.dart';
import 'chat_bubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Message> _messages = [];
  final TextEditingController _controller = TextEditingController();

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _messages.insert(0, Message(content: _controller.text, timestamp: DateTime.now().microsecondsSinceEpoch));
      });
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Chat')),//你可以启用这行
      appBar: null,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(message: _messages[index]); // 使用 ChatBubble 组件
              },
            ),
          ),
          MessageInputField(controller: _controller, onSendMessage: _sendMessage),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 1000; i++) {
      _messages.insert(i, Message(content: "消息$i"));
    }
  }
}

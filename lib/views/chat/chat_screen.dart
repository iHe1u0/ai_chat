import 'package:chat/viewmodels/chat_viewmodel.dart';
import 'package:chat/views/chat/chat_input.dart';
import 'package:flutter/material.dart';
import 'chat_bubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ChatViewModel _viewModel = ChatViewModel();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _viewModel.addListener(_onMessagesUpdated);
  }

  void _onMessagesUpdated() {
    setState(() {}); // Force to refresh UI
    _scrollToBottom();
  }

  void _sendMessage() {
    if (_controller.text.isNotEmpty) {
      _viewModel.sendMessage(_controller.text.trim());
      _controller.clear();
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              reverse: false,
              itemCount: _viewModel.messages.length,
              itemBuilder: (context, index) {
                return ChatBubble(message: _viewModel.messages[index]);
              },
            ),
          ),
          MessageInputField(controller: _controller, onSendMessage: _sendMessage),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _controller.dispose();
    _viewModel.removeListener(_onMessagesUpdated);
    _viewModel.dispose();
    super.dispose();
  }
}

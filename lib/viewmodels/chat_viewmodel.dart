import 'dart:async';
import 'package:chat/core/services/ollama_service.dart' show OllamaService;
import 'package:chat/models/message.dart';
import 'package:flutter/material.dart';

class ChatViewModel extends ChangeNotifier {
  final OllamaService _ollamaService = OllamaService();
  List<Message> messages = [];
  StreamSubscription<String>? _streamSubscription;

  void sendMessage(String userMessage) {
    messages.add(Message(sender: MessageSender.user, content: userMessage));
    notifyListeners();

    List<Map<String, String>> formattedMessages =
        messages.map((msg) => {"role": msg.sender.name, "content": msg.content}).toList();

    _streamSubscription = _ollamaService.chatWithOllama("qwen2.5:7b", formattedMessages).listen((responseText) {
      if (messages.isNotEmpty && messages.last.sender == MessageSender.assistant) {
        messages.last = Message(sender: MessageSender.assistant, content: messages.last.content + responseText);
      } else {
        messages.add(Message(sender: MessageSender.assistant, content: responseText));
      }
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }
}

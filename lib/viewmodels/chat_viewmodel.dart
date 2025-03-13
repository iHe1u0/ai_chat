import 'dart:async';
import 'package:chat/core/services/ollama_service.dart' show OllamaService;
import 'package:chat/models/message.dart';
import 'package:chat/viewmodels/settings_viewmodel.dart' show SettingsViewModel;
import 'package:flutter/material.dart';

class ChatViewModel extends ChangeNotifier {
  final OllamaService _ollamaService = OllamaService();
  final SettingsViewModel settingsViewModel; // 注入SettingsViewModel

  List<Message> messages = [];
  StreamSubscription<String>? _streamSubscription;

  ChatViewModel(this.settingsViewModel);

  void sendMessage(String userMessage) {
    messages.add(Message(sender: MessageSender.user, content: userMessage));
    notifyListeners();

    List<Map<String, String>> formattedMessages =
        messages.map((msg) => {"role": msg.sender.name, "content": msg.content}).toList();

    final selectedModel = settingsViewModel.settings.selectedModel ?? "qwen2.5:7b";

    _streamSubscription = _ollamaService.chatWithOllama(selectedModel, formattedMessages).listen((responseText) {
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

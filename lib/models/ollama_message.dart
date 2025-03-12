import 'dart:convert' show jsonDecode;

class Message {
  final String role;
  final String content;

  Message({required this.role, required this.content});

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(role: json['role'] as String, content: json['content'] as String);
  }
}

class OllamaChatApiResponse {
  final String model;
  final DateTime createdAt;
  final Message message;
  final bool done;

  OllamaChatApiResponse({required this.model, required this.createdAt, required this.message, required this.done});

  factory OllamaChatApiResponse.fromJson(String jsonString) {
    final Map<String, dynamic> json = jsonDecode(jsonString);

    return OllamaChatApiResponse(
      model: json['model'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      message: Message.fromJson(json['message'] as Map<String, dynamic>),
      done: json['done'] as bool,
    );
  }
}

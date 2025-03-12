import 'dart:convert';
import 'package:chat/core/config/env.dart';
import 'package:chat/models/ollama_message.dart' show OllamaChatApiResponse;
import 'package:http/http.dart' as http;

class OllamaService {
  final String apiUrl = "${Env.apiBaseUrl}/api/chat";

  Stream<String> chatWithOllama(String model, List<Map<String, String>> messages) async* {
    var request = http.Request("POST", Uri.parse(apiUrl));
    request.body = jsonEncode({"model": model, "messages": messages, "stream": true});

    request.headers["Content-Type"] = "application/json";

    var response = await request.send();
    await for (var chunk in response.stream.transform(utf8.decoder)) {
      try {
        String content = OllamaChatApiResponse.fromJson(chunk).message.content;
        yield content;
      } catch (e) {
        yield "_";
      }
    }
  }
}

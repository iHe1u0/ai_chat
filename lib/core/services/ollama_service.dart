import 'dart:convert';
import 'package:http/http.dart' as http;

class OllamaService {
  final String apiUrl = "http://192.168.0.107:11434/api/chat";

  Stream<String> chatWithOllama(String model, List<Map<String, String>> messages) async* {
    var request = http.Request("POST", Uri.parse(apiUrl));
    request.body = jsonEncode({"model": model, "messages": messages, "stream": true});

    request.headers["Content-Type"] = "application/json";

    var response = await request.send();
    await for (var chunk in response.stream.transform(utf8.decoder)) {
      var data = jsonDecode(chunk);
      if (data.containsKey("message")) {
        yield data["message"]["content"];
      }
    }
  }
}

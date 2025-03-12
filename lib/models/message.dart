import 'package:intl/intl.dart' show DateFormat;
import 'package:timeago/timeago.dart' as timeago show format;

enum MessageType { text, image, video, audio, file }

enum MessageStatus { sending, sent, delivered, read, failed }

enum MessageSender { system, assistant, user }

class Message {
  final String id; // Message ID
  final MessageSender sender; // Sender ID, system/assistant/user
  final String content; // Message content (text or file path)
  final MessageType type; // Message type (text, image, video, etc.)
  final MessageStatus status; // Message status (sent, read, etc.)
  final int timestamp; // Sent time

  Message({
    required this.content,
    this.id = "0",
    this.sender = MessageSender.user,
    this.type = MessageType.text,
    this.status = MessageStatus.sending,
    int? timestamp,
  }) : timestamp = timestamp ?? DateTime.now().millisecondsSinceEpoch;

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      sender: MessageSender.values.firstWhere((e) => e.toString() == 'MessageSender.${json['type']}'),
      content: json['content'],
      type: MessageType.values.firstWhere((e) => e.toString() == 'MessageType.${json['type']}'),
      status: MessageStatus.values.firstWhere((e) => e.toString() == 'MessageStatus.${json['status']}'),
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender': sender.toString().split('.').last,
      'content': content,
      'type': type.toString().split('.').last,
      'status': status.toString().split('.').last,
      'timestamp': timestamp.toString(),
    };
  }

  String getTime() {
    final DateTime now = DateTime.now();
    final DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    if (now.difference(date).inHours < 24) {
      return timeago.format(date);
    } else {
      return DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
    }
  }
}

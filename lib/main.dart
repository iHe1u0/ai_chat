import 'package:chat/app.dart';
import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago show ZhMessages, setLocaleMessages;
// import 'package:provider/provider.dart';
// import 'app.dart';
// import 'core/services/chat_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 确保异步操作可以执行

  // Initialize Services
  // final chatService = ChatService();
  // await chatService.init();

  // runApp(MultiProvider(providers: [ChangeNotifierProvider(create: (_) => chatService)], child: const MyApp()));

  timeago.setLocaleMessages('zh', timeago.ZhMessages());

  runApp(const KApp());
}

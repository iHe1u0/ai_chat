import 'package:chat/routes/app_routes.dart';
import 'package:chat/viewmodels/chat_viewmodel.dart';
import 'package:chat/views/chat/chat_input.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' show Provider;
import 'chat_bubble.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  late ChatViewModel _viewModel; // 用 late 延迟初始化

  @override
  void initState() {
    super.initState();
    _viewModel = Provider.of<ChatViewModel>(context, listen: false); // 在 initState 里初始化
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
      appBar: AppBar(
        title: const Text("AI Chat", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 2,
        leading: Builder(
          builder: (context) => IconButton(icon: Icon(Icons.menu), onPressed: () => Scaffold.of(context).openDrawer()),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              router.go("/settings");
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.blueAccent),
              child: Text('侧边菜单', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: Icon(Icons.chat),
              title: Text('聊天记录'),
              onTap: () {
                debugPrint("进入聊天记录");
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('关于我们'),
              onTap: () {
                debugPrint("查看关于");
              },
            ),
          ],
        ),
      ),
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

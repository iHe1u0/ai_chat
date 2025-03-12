import 'package:chat/models/message.dart';
import 'package:chat/widgets/avatar.dart' show Avatar;
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter_markdown/flutter_markdown.dart' show MarkdownBody;

class ChatBubble extends StatelessWidget {
  final Message message;

  const ChatBubble({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    Color secondaryBackground = Theme.of(context).colorScheme.secondaryContainer;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Avatar(sender: message.sender),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(message.sender.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                const SizedBox(height: 2),
                Text(message.getTime(), style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: secondaryBackground, borderRadius: BorderRadius.circular(10)),
                  child: SelectableText(message.content),
                  // child: SafeArea(
                  //   child: MarkdownBody(
                  //     data: message.content,
                  //     selectable: true,
                  //     // builders: {'latex': LatexElementBuilder(textScaleFactor: 1.0)},
                  //     // extensionSet: md.ExtensionSet([LatexBlockSyntax()], [LatexInlineSyntax()]),
                  //   ),
                  // ),
                ),
              ],
            ),
          ),
          // IconButton(onPressed: () {}, icon: Icon(Icons.stop)),
        ],
      ),
    );
  }
}

import 'package:chat/models/message.dart';
import 'package:flutter/material.dart';

class Avatar extends StatelessWidget {
  final MessageSender sender;

  const Avatar({required this.sender, super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset("assets/images/ic_${sender.name}.png", height: 48, width: 48);
  }
}

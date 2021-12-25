import 'package:chat/src/widgets/chatList_Item.dart';
import 'package:flutter/material.dart';

List<Widget> chatList = const [];

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      children: [
        const SizedBox(
          height: 20,
        ),
        ...chatList
      ],
    );
  }
}

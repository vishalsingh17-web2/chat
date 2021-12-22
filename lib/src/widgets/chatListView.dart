import 'package:chat/src/widgets/personalChatList.dart';
import 'package:flutter/material.dart';

List<Widget> chatList = const [
  ChatListItem(
    name: 'Vishal Singh',
    imageUrl: 'assets/images/profile.png',
    message: 'Hey, how are you?',
    time: '12:00',
    isSelected: false,
  ),
  ChatListItem(
    name: 'Aman',
    imageUrl: 'assets/images/profile.png',
    message: 'Hey, how are you?',
    time: '12:00',
    isSelected: false,
  ),
  ChatListItem(
    name: 'Aratrik',
    imageUrl: 'assets/images/profile.png',
    message: 'Hey, how are you?',
    time: '12:00',
    isSelected: false,
  ),
  ChatListItem(
    name: 'Tanishq',
    imageUrl: 'assets/images/profile.png',
    message: 'Hey, how are you?',
    time: '12:00',
    isSelected: false,
  ),
  ChatListItem(
    name: 'Siddhu',
    imageUrl: 'assets/images/profile.png',
    message: 'Hey, how are you?',
    time: '12:00',
    isSelected: false,
  ),
  ChatListItem(
    name: 'Arpit',
    imageUrl: 'assets/images/profile.png',
    message: 'Hey, how are you?',
    time: '12:00',
    isSelected: false,
  ),
  ChatListItem(
    name: 'Vishal Singh',
    imageUrl: 'assets/images/profile.png',
    message: 'Hey, how are you?',
    time: '12:00',
    isSelected: false,
  ),
];

class ChatView extends StatefulWidget {
  final ScrollController controller;
  const ChatView({Key? key, required this.controller}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  
  @override
  Widget build(BuildContext context) {
    return ListView(
      controller: widget.controller,
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      children:chatList
          
    );
  }
}

import 'package:flutter/material.dart';

import 'groupList_item.dart';

List<Widget> chatList = const [
  GroupListItem(
    name: 'Vishal Singh',
    imageUrl: 'assets/images/profile.png',
    message: 'Hey, how are you?',
    time: '12:00',
    isSelected: false,
  ),
  GroupListItem(
    name: 'Aman',
    imageUrl: 'assets/images/profile.png',
    message: 'Hey, how are you?',
    time: '12:00',
    isSelected: false,
  ),
  GroupListItem(
    name: 'Aratrik',
    imageUrl: 'assets/images/profile.png',
    message: 'Hey, how are you?',
    time: '12:00',
    isSelected: false,
  ),
  GroupListItem(
    name: 'Tanishq',
    imageUrl: 'assets/images/profile.png',
    message: 'Hey, how are you?',
    time: '12:00',
    isSelected: false,
  ),
  GroupListItem(
    name: 'Siddhu',
    imageUrl: 'assets/images/profile.png',
    message: 'Hey, how are you?',
    time: '12:00',
    isSelected: false,
  ),
  GroupListItem(
    name: 'Arpit',
    imageUrl: 'assets/images/profile.png',
    message: 'Hey, how are you?',
    time: '12:00',
    isSelected: false,
  ),
  GroupListItem(
    name: 'Vishal Singh',
    imageUrl: 'assets/images/profile.png',
    message: 'Hey, how are you?',
    time: '12:00',
    isSelected: false,
  ),
];

class GroupView extends StatefulWidget {
  const GroupView({Key? key}) : super(key: key);

  @override
  State<GroupView> createState() => _GroupViewState();
}

class _GroupViewState extends State<GroupView> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      children: [
        const SizedBox(
          height: 20,
        ),
        // ...chatList
      ],
    );
  }
}

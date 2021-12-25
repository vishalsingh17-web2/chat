import 'package:chat/components/shared_database.dart';
import 'package:chat/src/Screens/chatScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatListItem extends StatelessWidget {
  final String name;
  final String message;
  final String time;
  final String imageUrl;
  const ChatListItem(
      {Key? key,
      required this.name,
      required this.imageUrl,
      required this.message,
      required this.time,
      required bool isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => ChatScreen(user: SharedData.userObject!,),
          ),
        );
      },
      leading: CircleAvatar(
        backgroundColor: Colors.grey,
        child: Image.asset(imageUrl),
      ),
      title: Text(name, style: Theme.of(context).textTheme.headline3),
      subtitle: Text(message,
          style: const TextStyle(
              color: Color.fromRGBO(170, 170, 170, 0.8), fontSize: 16)),
      trailing: Text(time, style: Theme.of(context).textTheme.caption),
    );
  }
}

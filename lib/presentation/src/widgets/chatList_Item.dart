import 'package:chat/components/shared_database.dart';
import 'package:chat/hive/boxes.dart';
import 'package:chat/hive/conversation/conversation.dart';
import 'package:chat/hive/user/user_info.dart';
import 'package:chat/presentation/src/Screens/chatScreen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ChatListItem extends StatelessWidget {
  final UserInf userInf;
  final String message;
  final String time;
  const ChatListItem({
    Key? key,
    required this.message,
    required this.time,
    required this.userInf,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () async {
        await Boxes.openConversationBox(userInf.uid);
        Navigator.of(context).push(
          CupertinoPageRoute(
            builder: (context) => ChatScreen(
              user: userInf,
            ),
          ),
        );
      },
      leading: CircleAvatar(
        backgroundColor: Colors.grey,
        child: ClipOval(
            child: Image.network(userInf.image, height: 40, width: 40)),
      ),
      title: Text(userInf.name, style: Theme.of(context).textTheme.headline3),
      subtitle: Text(
        message,
        style: Theme.of(context).textTheme.bodyText1!.copyWith(
          fontWeight: FontWeight.w400,
              fontSize: 15,
            ),
      ),
      trailing: Text(time, style: Theme.of(context).textTheme.caption),
    );
  }
}

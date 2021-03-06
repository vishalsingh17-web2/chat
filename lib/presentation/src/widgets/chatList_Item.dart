import 'package:chat/components/shared_database.dart';
import 'package:chat/firebase/authentication.dart';
import 'package:chat/hive/boxes.dart';
import 'package:chat/hive/conversation/conversation.dart';
import 'package:chat/hive/user/user_info.dart';
import 'package:chat/presentation/provider/users_data.dart';
import 'package:chat/presentation/src/Screens/chatScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

class ChatListItem extends StatelessWidget {
  final UserInf userInf;
  final String message;
  final String time;
  final bool isOnline;
  const ChatListItem({
    Key? key,
    required this.message,
    required this.time,
    required this.userInf,
    required this.isOnline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(userInf.uid),
      background: Container(
        color: Colors.red,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      direction: DismissDirection.endToStart,
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title:
                    const Text('Are you sure?', style: TextStyle(fontSize: 25)),
                content: const Text('Do you want to delete this conversation?'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop(false);
                    },
                  ),
                  TextButton(
                    child: const Text('Delete'),
                    onPressed: () {
                      Navigator.of(context).pop(true);
                    },
                  ),
                ],
              );
            });
      },
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          Boxes.deleteUserConversation(uid: userInf.uid);
          Boxes.deleteUserData(uid: userInf.uid);
        }
      },
      child: ListTile(
        onTap: () async {
          await Boxes.openConversationBox(userInf.uid);
          Provider.of<UserData>(context, listen: false)
              .getUserFCMwithEmail(userInf.email);
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
          overflow: TextOverflow.ellipsis,
        ),
        trailing: SizedBox(
          width: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 7,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isOnline ? Colors.green : Colors.grey,
                ),
              ),
              Text(time, style: Theme.of(context).textTheme.caption),
            ],
          ),
        ),
      ),
    );
  }
}

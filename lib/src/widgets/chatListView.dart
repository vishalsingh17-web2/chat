import 'package:chat/hive/boxes.dart';
import 'package:chat/hive/user_info.dart';
import 'package:chat/src/widgets/chatList_Item.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Box<UserInf>>(
      valueListenable: Boxes.getUserInfoBox().listenable(),
      builder: (context, userInf, _) {
        final user = userInf.values.toList().cast<UserInf>();
        if (user == null) {
          return Container();
        }
        return ListView.builder(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          itemCount: user.length,
          itemBuilder: (context, index) {
            if (Boxes.getCurrentUserInfo()!.uid == user[index].uid) {
              return Container();
            }

            return ChatListItem(
              userInf: user[index],
              message: '',
              time: '',
            );
          },
        );
      },
    );
  }
}

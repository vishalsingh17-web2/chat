import 'package:chat/hive/boxes.dart';
import 'package:chat/hive/user/user_info.dart';
import 'package:chat/presentation/provider/typing_provider.dart';
import 'package:chat/presentation/src/widgets/chatList_Item.dart';

import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';

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
        return RefreshIndicator(
          color: Theme.of(context).primaryColor,
          onRefresh: () async {
            await Boxes.openAllConversationBox();
            return Future.delayed(const Duration(seconds: 1));
          },
          child: ListView.builder(
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            itemCount: user.length,
            itemBuilder: (context, index) {
              if (Boxes.getCurrentUserInfo()!.uid == user[index].uid) {
                return Container();
              }
              return Consumer<OnlineStatusProvider>(
                builder: (context, provider, _) {
                  if (provider.uid == user[index].uid) {
                    return ChatListItem(
                      userInf: user[index],
                      message:
                          Boxes.getLastMessage(user[index].uid)?.message ?? '',
                      time: Boxes.getLastMessage(user[index].uid)?.time ?? '',
                      isOnline: true,
                    );
                  } else {
                    return ChatListItem(
                      userInf: user[index],
                      message:
                          Boxes.getLastMessage(user[index].uid)?.message ?? '',
                      time: Boxes.getLastMessage(user[index].uid)?.time ?? '',
                      isOnline: false,
                    );
                  }
                },
              );
            },
          ),
        );
      },
    );
  }
}

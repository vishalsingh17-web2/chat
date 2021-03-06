import 'dart:async';
import 'dart:io';

import 'package:chat/data/socket_controller.dart';
import 'package:chat/firebase/authentication.dart';
import 'package:chat/hive/boxes.dart';
import 'package:chat/hive/conversation/conversation.dart';
import 'package:chat/main.dart';
import 'package:chat/hive/user/user_info.dart';
import 'package:chat/presentation/provider/typing_provider.dart';
import 'package:chat/presentation/provider/users_data.dart';
import 'package:chat/presentation/src/widgets/chatBox.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

ScrollController controller = ScrollController();

class ChatScreen extends StatefulWidget {
  final UserInf user;
  ChatScreen({Key? key, required this.user}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

List<Widget> conversation = [];

class _ChatScreenState extends State<ChatScreen> {
  bool show = false;


  TextEditingController _msgController = TextEditingController();
  StreamController<String> streamController =
      StreamController<String>.broadcast();

  @override
  void initState() {
    streamController.stream.listen((event) {
      debugPrint(event);
      if (event == "typing") {
        sendTyping(targetId: widget.user.uid, isTyping: true);
      } else if (event == "stop typing") {
        sendTyping(targetId: widget.user.uid, isTyping: false);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    streamController.add("stop typing");
    streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return SafeArea(
      child: Material(
        child: Container(
          padding: MediaQuery.of(context).viewInsets,
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15.0,
                  horizontal: 20.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipOval(
                      child: Image.network(
                        widget.user.image,
                        height: 40,
                        width: 40,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.user.name,
                          style: Theme.of(context).textTheme.headline3,
                        ),
                        Consumer<TypingProvider>(builder: (context, typing, _) {
                          return Text(
                            typing.isTyping && typing.uid == widget.user.uid
                                ? 'typing...'
                                : '',
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.grey, fontSize: 13),
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 20,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: ValueListenableBuilder<Box<ChatModel>>(
                    valueListenable:
                        Hive.box<ChatModel>(widget.user.uid).listenable(),
                    builder: (context, box, child) {
                      var chat = box.values.toList().cast<ChatModel>();
                      return ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context, index) {
                          return ChatBox(
                            sentByMe: chat[index].sentByMe,
                            message: chat[index].message,
                            time: chat[index].time,
                          );
                        },
                        itemCount: chat.length,
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Consumer<TypingProvider>(
                    builder: (context, typing, _) {
                      return ListTile(
                        title: TextFormField(
                          onChanged: (value) {
                            streamController.add("typing");
                          },
                          cursorColor: Theme.of(context).primaryColor,
                          controller: _msgController,
                          decoration: InputDecoration(
                            hintText: "Type a message",
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(
                                color: Theme.of(context).unselectedWidgetColor,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: const BorderSide(
                                color: Colors.blueGrey,
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.send,
                            color: Theme.of(context).iconTheme.color,
                          ),
                          onPressed: () async{
                            streamController.add("stop typing");
                            
                            if (_msgController.text.isNotEmpty) {
                              debugPrint(Provider.of<UserData>(context,listen: false).fcmToken,);
                              sendMessage(
                                message: _msgController.text,
                                sourceId: Boxes.getCurrentUserInfo()!.uid,
                                targetId: widget.user.uid,
                                time: DateFormat.jm().format(DateTime.now()),
                                name: Boxes.getCurrentUserInfo()!.name,
                                fcmToken: Provider.of<UserData>(context,listen: false).fcmToken,
                              );
                              Boxes.addCoversation(
                                chatModel: ChatModel(
                                  sentByMe: true,
                                  message: _msgController.text,
                                  time: DateFormat.jm().format(DateTime.now()),
                                ),
                                id: widget.user.uid,
                              );
                              setState(
                                () {
                                  _msgController.clear();
                                  controller.animateTo(
                                    0.0,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.fastOutSlowIn,
                                  );
                                },
                              );
                            }
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}

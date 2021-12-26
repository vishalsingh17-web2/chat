import 'dart:io';

import 'package:chat/hive/boxes.dart';
import 'package:chat/main.dart';
import 'package:chat/hive/user_info.dart';
import 'package:chat/src/widgets/chatBox.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

ScrollController controller = ScrollController();
List<Widget> conversation = [];

class ChatScreen extends StatefulWidget {
  final UserInf user;
  ChatScreen({Key? key, required this.user}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool show = false;

  TextEditingController _msgController = TextEditingController();

  @override
  void initState() {
    SocketIO.init();
    SocketIO.socket!.onConnect((data) {
      SocketIO.socket!.on('message', (msg) {
        print(msg);
        if (msg['sourceId'] == widget.user.uid &&
            msg['targetId'] == Boxes.getCurrentUserInfo()!.uid) {
          setState(() {
            conversation.add(ChatBox(
              sentByMe: false,
              message: msg['message'],
              time: DateFormat.Hm()
                  .format(DateTime.parse(msg['time']))
                  .toString(),
            ));
          });
        }
      });
    });

    controller.animateTo(
      0.0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
    super.initState();
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
                    Text(
                      '${widget.user.name}',
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 20,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: ListView(
                    reverse: true,
                    physics: const BouncingScrollPhysics(),
                    controller: controller,
                    children: [...conversation.reversed],
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: ListTile(
                    title: TextFormField(
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
                      onPressed: () {
                        if (_msgController.text.length != 0) {
                          setState(
                            () {
                              conversation.add(
                                ChatBox(
                                  sentByMe: true,
                                  message: _msgController.text,
                                  time:
                                      "${DateFormat.Hm().format(DateTime.now())}",
                                ),
                              );
                              SocketIO.sendMessage(
                                message: _msgController.text,
                                sourceId: Boxes.getCurrentUserInfo()!.uid,
                                targetId: widget.user.uid,
                                time: DateTime.now().toString(),
                              );
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

import 'dart:io';

import 'package:chat/main.dart';
import 'package:chat/models/hive/user_info.dart';
import 'package:chat/src/widgets/chatBox.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

ScrollController controller = ScrollController();
List<Widget> conversation = [
  const ChatBox(
    message: 'You look bit down. What’s the matter?',
    sentByMe: false,
    time: '07:52',
  ),
  const ChatBox(
    sentByMe: true,
    message: 'Nothing much.',
    time: '07:53',
  ),
  const ChatBox(
    sentByMe: false,
    message: 'Looks like something isn’t right.',
    time: '07:53',
  ),
  const ChatBox(
      sentByMe: true,
      time: '07:54',
      message:
          'Ya. It’s at the job front. You know that the telecom industry is going through a rough patch because of falling prices and shrinking margins. These factors along with consolidation in the industry is threatening the stability of our jobs. And even if the job remains, career growth isn’t exciting.'),
  const ChatBox(
    sentByMe: false,
    time: '07:55',
    message:
        'I know. I’ve been reading about some of these issues about your industry in the newspapers. So have you thought of any plan?',
  ),
  const ChatBox(
    sentByMe: true,
    time: '07:56',
    message:
        'I’ve been thinking about it for a while, but haven’t concretized anything so far.',
  ),
  const ChatBox(
    sentByMe: false,
    time: '07:57',
    message: 'What have you been thinking😁, if you can share?',
  )
];

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
                              SocketIO.sendMessage(_msgController.text);
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

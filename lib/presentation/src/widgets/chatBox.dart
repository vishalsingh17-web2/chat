import 'package:flutter/material.dart';

class ChatBox extends StatelessWidget {
  final bool sentByMe;
  final String message;
  final String time;
  const ChatBox({
    Key? key,
    required  this.sentByMe,
    required  this.message,
    required  this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          sentByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        sentByMe
            ? Container(
                width: MediaQuery.of(context).size.width * 0.75,
                margin: const EdgeInsets.symmetric(vertical: 5),
                alignment: Alignment.centerRight,
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Theme.of(context).splashColor,
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        bottomLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                  ),
                  child: RichText(
                    textAlign: TextAlign.right,
                    text: TextSpan(
                      text: message,
                      style: Theme.of(context).textTheme.bodyText1,
                      children: [
                        TextSpan(
                          text: '\n',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        TextSpan(
                          text: time,
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Theme.of(context).unselectedWidgetColor,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                width: MediaQuery.of(context).size.width * 0.75,
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Theme.of(context).secondaryHeaderColor,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                        topLeft: Radius.circular(15)),
                  ),
                  child: RichText(
                    text: TextSpan(
                      text: message,
                      style: Theme.of(context).textTheme.bodyText1,
                      children: [
                        TextSpan(
                          text: '\n',
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        TextSpan(
                          spellOut: true,
                          text: time,
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Theme.of(context).unselectedWidgetColor,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
      ],
    );
  }
}

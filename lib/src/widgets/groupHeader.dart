import 'dart:math';

import 'package:flutter/material.dart';

class GroupHeader extends StatelessWidget {
  final List<String> imageUrl;

  GroupHeader({Key? key, required this.imageUrl}) : super(key: key);

  List<Widget> getMemebers() {
    List<Widget> members = [];
    for (int i = 0; i < imageUrl.length; i++) {
      members.add(
        Container(
            alignment:
                i % 2 == 0 ? Alignment.topCenter : Alignment.bottomCenter,
            height: 50,
            width: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: _profile(imageUrl: imageUrl[i])),
      );
    }
    return members;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: getMemebers(),
      ),
    );
  }

  Widget _profile({required String imageUrl}) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
      ),
      child: ClipOval(
        child: Image.asset(imageUrl, width: 30, height: 30),
      ),
    );
  }
}

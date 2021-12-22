import 'package:chat/src/Screens/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var myMenuItems = <String>[
  'Profile',
  'Settings',
];

Widget profileHeader({
  required BuildContext context,
  required String name,
  required String imageUrl,
}) {
  return ListTile(
    leading: Container(
      height: 50,
      width: 50,
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFB347EA),
              Colors.indigo,
              Colors.blue,
              Colors.green,
              Colors.yellow,
              Colors.orange,
              Colors.red
            ]),
        borderRadius: BorderRadius.all(Radius.circular(50)),
      ),
      child: ClipOval(
        child: Image.asset(
          imageUrl,
        ),
      ),
    ),
    title: Text(name, style: Theme.of(context).textTheme.headline3),
    trailing: PopupMenuButton<String>(
      onSelected: (item) {
        switch (item) {
          case 'Profile':
            print('Profile clicked');
            break;
          case 'Settings':
          print('Setting clicked');
            Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (context) => Settings(),
              ),
            );
            
            break;
        }
      },
      itemBuilder: (BuildContext context) {
        return myMenuItems.map((String choice) {
          return PopupMenuItem<String>(
            child: Text(choice),
            value: choice,
          );
        }).toList();
      },
    ),
  );
}

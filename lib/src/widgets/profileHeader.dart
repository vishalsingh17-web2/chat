import 'package:chat/components/shared_database.dart';
import 'package:chat/firebase/authentication.dart';
import 'package:chat/src/Screens/login.dart';
import 'package:chat/src/Screens/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var myMenuItems = <String>[
  'Profile',
  'Settings',
  'Logout',
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
        child: Image.network(
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
            Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (context) => Login(),
              ),
            );
            break;
          case 'Settings':
            print('Setting clicked');
            Navigator.of(context).push(
              CupertinoPageRoute(
                builder: (context) => Settings(),
              ),
            );
            break;
          case 'Logout':
            FirebaseService.signOutFromGoogle();
            SharedData.setLoginStatus(false);
            print('Logout clicked');
            Navigator.of(context).pushReplacement(
              CupertinoPageRoute(
                builder: (context) => Login(),
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

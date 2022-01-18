import 'package:chat/firebase/authentication.dart';
import 'package:chat/hive/boxes.dart';
import 'package:chat/presentation/src/Screens/login.dart';
import 'package:chat/presentation/src/Screens/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

var myMenuItems = <String>[
  'Profile',
  'Settings',
  'Logout',
];
Widget action(BuildContext context) {
  return PopupMenuButton<String>(
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
          Boxes.getUserInfoBox().deleteAll(Boxes.getUserInfoBox().keys);
          // Boxes.setCurrentUserBox().delete('currentUser');

          // SharedData.setLoginStatus(false);
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
  );
}

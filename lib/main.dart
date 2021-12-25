import 'dart:io';

import 'package:chat/components/hive_database.dart';
import 'package:chat/firebase/authentication.dart';
import 'package:chat/src/Screens/homepage.dart';
import 'package:chat/src/Screens/login.dart';
import 'package:chat/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'components/shared_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Init.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

ThemeBloc themeBloc = ThemeBloc();

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        initialData: SharedData.theme ?? SharedData.defaultTheme,
        stream: themeBloc.themeStream,
        builder: (context, AsyncSnapshot<bool> snapshot) {
          Constant.isDark = snapshot.data!;
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Chat',
            theme: snapshot.data! ? ThemeX.darkTheme() : ThemeX.lightTheme(),
            home: SharedData.isLoggedIn != null ? HomePage() : const Login(),
          );
        });
  }
}

class SocketIO {
  static var socket;
  static void init() {
    socket = IO.io('http://192.168.1.9:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();
  }

  static void sendMessage(String message) {
    socket.emit('/test', message);
  }
}

class Init {
  static init() async {
    await SharedData.setDefaultTheme(true);
    await SharedData.init();
    await Firebase.initializeApp();
    SocketIO.init();
    

    var media = await Permission.accessMediaLocation.request();
    var storage = await Permission.storage.request();
    Directory appDocDir = await getApplicationDocumentsDirectory();
    String appDocPath = appDocDir.path;
    if (storage.isGranted && media.isGranted) {
      Hive.init(appDocPath);
    }
    
    // HelperData.getData();
  }
}

import 'package:chat/hive/user_info.dart';
import 'package:chat/src/Screens/homepage.dart';
import 'package:chat/src/Screens/login.dart';
import 'package:chat/theme/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'hive/boxes.dart';

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
check() {
  FirebaseAuth _firebase = FirebaseAuth.instance;
  if (_firebase.currentUser != null) {
    return HomePage();
  } else {
    return Login();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      initialData: Boxes.getTheme() ?? true,
      stream: themeBloc.themeStream,
      builder: (context, AsyncSnapshot<bool> snapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Chat',
          theme: snapshot.data! ? ThemeX.darkTheme() : ThemeX.lightTheme(),
          home: check(),
        );
      },
    );
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
    await Firebase.initializeApp();
    SocketIO.init();
    await Hive.initFlutter();
    Hive.registerAdapter(UserInfAdapter());
    await Boxes.init();
  }
}

import 'dart:async';

import 'package:chat/data/socket_controller.dart';
import 'package:chat/firebase/authentication.dart';
import 'package:chat/hive/conversation/conversation.dart';
import 'package:chat/presentation/provider/connectivity_provider.dart';
import 'package:chat/presentation/provider/theme_provider.dart';
import 'package:chat/presentation/provider/typing_provider.dart';
import 'package:chat/presentation/provider/user_provider.dart';
import 'package:chat/presentation/provider/users_data.dart';
import 'package:chat/presentation/src/Screens/homepage.dart';
import 'package:chat/presentation/src/Screens/login.dart';
import 'package:chat/presentation/theme/theme.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'hive/boxes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Init.init();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

check() {
  FirebaseAuth _firebase = FirebaseAuth.instance;
  if (_firebase.currentUser != null) {
    connectToServer();
    sendIsOnline(isOnline: true);
    return HomePage();
  } else {
    return Login();
  }
}

StreamController _streamController = StreamController();
bool _isConnected = false;
initializeToken()async{
    String? token = await FirebaseMessaging.instance.getToken();
    debugPrint("-------------------------"+token!);
    Boxes.setFCMToken(token.toString());
    FirebaseService.writeData();
}
class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    initializeToken();
    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        showSimpleNotification(
          Text(message.notification!.title.toString()),
          subtitle: Text(message.notification!.body.toString()),
          trailing:const Icon(Icons.notifications),
        );
      }
    });
    FirebaseMessaging.onBackgroundMessage((RemoteMessage message){
      if (message.notification != null) {
        showSimpleNotification(
          Text(message.notification!.title.toString()),
          subtitle: Text(message.notification!.body.toString()),
          trailing:const Icon(Icons.notifications),
        );
        ChatModel chatModel = ChatModel(
          message: message.notification!.title.toString(),
          sentByMe: false,
          time: message.data["time"],
        );
        Boxes.addCoversation(chatModel: chatModel, id: message.data["sourceId"]);
      }
      
      return Future.value(2);
  
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) { 
      if (message.notification != null) {
        
        showSimpleNotification(
          Text(message.notification!.title.toString()),
          subtitle: Text(message.notification!.body.toString()),
          trailing:const Icon(Icons.notifications),
          
        );
        ChatModel chatModel = ChatModel(
          message: message.notification!.title.toString(),
          sentByMe: false,
          time: message.data["time"],
        );
        Boxes.addCoversation(chatModel: chatModel, id: message.data["sourceId"]);
      }
    });
    super.initState();
    Connectivity().onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.none) {
        _isConnected = false;
        showSimpleNotification(
          const Text("No Internet Connection"),
          background: Colors.red.shade300,
        );
        _streamController.sink.add(_isConnected);
      } else {
        _isConnected = true;
        showSimpleNotification(
          const Text("Connected"),
          background: Colors.green.shade300,
        );
        _streamController.sink.add(_isConnected);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => TypingProvider()),
        ChangeNotifierProvider(create: (context) => OnlineStatusProvider()),
        ChangeNotifierProvider(create: (context) => UserData())
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return OverlaySupport(
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Chat',
              theme: themeProvider.themeData,
              home: check(),
            ),
          );
        },
      ),
    );
  }
}

class Init {
  static init() async {
    await Firebase.initializeApp();
    await Hive.initFlutter();
    await Boxes.init();
    Boxes.setlightTheme();
  }
}

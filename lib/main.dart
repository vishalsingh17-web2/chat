import 'dart:async';

import 'package:chat/data/socket_controller.dart';
import 'package:chat/presentation/provider/connectivity_provider.dart';
import 'package:chat/presentation/provider/theme_provider.dart';
import 'package:chat/presentation/provider/typing_provider.dart';
import 'package:chat/presentation/provider/user_provider.dart';
import 'package:chat/presentation/src/Screens/homepage.dart';
import 'package:chat/presentation/src/Screens/login.dart';
import 'package:chat/presentation/theme/theme.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
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

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    Connectivity().onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.none) {
        _isConnected = false;
        sendIsOnline(isOnline: false);
        _streamController.sink.add(_isConnected);
      } else {
        _isConnected = true;
        sendIsOnline(isOnline: true);
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
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return StreamBuilder(
            builder: (context, AsyncSnapshot snapshot) {
              if(snapshot.data == null) {
               return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Chat',
                  theme: themeProvider.themeData,
                  home: const SafeArea(
                    child: Scaffold(
                      body: LinearProgressIndicator()
                    ),
                  )
                );
              }
              if (snapshot.data) {
                
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Chat',
                  theme: themeProvider.themeData,
                  home: check(),
                );
              } else {
                return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Chat',
                  theme: themeProvider.themeData,
                  home: const Scaffold(
                    body: Center(
                      child: Text('No Internet Connection'),
                    ),
                  ),
                );
              }
            },
            stream: _streamController.stream,
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

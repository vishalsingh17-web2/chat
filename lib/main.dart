import 'package:chat/presentation/provider/theme_provider.dart';
import 'package:chat/presentation/provider/user_provider.dart';
import 'package:chat/presentation/src/Screens/homepage.dart';
import 'package:chat/presentation/src/Screens/login.dart';
import 'package:chat/presentation/theme/theme.dart';
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
    return HomePage();
  } else {
    return Login();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => UserProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Chat',
            theme: themeProvider.themeData,
            home: check(),
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

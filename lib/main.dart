import 'package:chat/src/Screens/homepage.dart';
import 'package:chat/src/Screens/login.dart';
import 'package:chat/theme/theme.dart';
import 'package:flutter/material.dart';
import 'components/shared_database.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedData.setDefaultTheme(true);
  await SharedData.init();
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
      initialData: SharedData.theme??SharedData.defaultTheme,
      stream: themeBloc.themeStream,
      builder: (context, AsyncSnapshot<bool> snapshot) {
        Constant.isDark = snapshot.data!;
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Chat',
          theme: snapshot.data!?ThemeX.darkTheme():ThemeX.lightTheme(),
          home: SharedData.isLoggedIn!=null?HomePage():const Login(),
        );
      }
    );
  }
}

import 'package:chat/src/Screens/homepage.dart';
import 'package:chat/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'components/shared_database.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

ThemeBloc themeBloc = ThemeBloc();
class _MyAppState extends State<MyApp> {
  // getTheme()async{
  //   bool x = await SharedData.getTheme();
  //   Constant.isDark = x;
  //   setState(() {
      
  //   });
  // }
  // @override
  // void initState() {
  //   getTheme();
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      initialData:Constant.isDark,
      stream: themeBloc.themeStream,
      builder: (context, AsyncSnapshot<bool> snapshot) {
        print("Main SnapshotTheme: ${snapshot.data} Constant.darkTheme:${Constant.isDark}");
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Chat',
          theme: snapshot.data!?ThemeX.darkTheme():ThemeX.lightTheme(),
          home: HomePage(),
        );
      }
    );
  }
}

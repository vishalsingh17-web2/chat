import 'package:chat/components/shared_database.dart';
import 'package:chat/main.dart';
import 'package:chat/theme/theme.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text('Settings'),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text("Dark Mode"),
            trailing: Switch(
              value: Constant.isDark,
              onChanged: (value) async {
                themeBloc.changeTheme(value);
                Constant.isDark = value;
                await SharedData.setTheme(value);
                await SharedData.init();
              },
            ),
          )
        ],
      ),
    );
  }
}

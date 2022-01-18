import 'package:chat/components/shared_database.dart';
import 'package:chat/hive/boxes.dart';
import 'package:chat/main.dart';
import 'package:chat/presentation/provider/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
          Consumer<ThemeProvider>(
            builder: (context,themeProvider, child) {
              return SwitchListTile(
                title: const Text('Dark Mode'),
                value: Boxes.getTheme(),
                onChanged: (value) {
                 themeProvider.changeTheme();
                },
              );
            },
            
          )
        ],
      ),
    );
  }
}

import 'package:chat/components/shared_database.dart';
import 'package:chat/firebase/authentication.dart';
import 'package:chat/hive/boxes.dart';
import 'package:chat/src/Screens/homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../main.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF58524),
              Color(0xFFF92B7F),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                CupertinoIcons.chat_bubble_text,
                size: 150,
                color: Colors.white,
              ),
              const Text(
                "Let's Chat",
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 70),
              const Text(
                "Sign in to your account",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Continue with Google',
                        style:
                            TextStyle(fontSize: 25, color: Color(0xFFF58524)),
                      ),
                      const SizedBox(width: 15),
                      ClipOval(
                        child: Image.asset(
                          'assets/images/google.png',
                          height: 25,
                          width: 25,
                        ),
                      )
                    ],
                  ),
                ),
                onPressed: () async {
                  await FirebaseService.signInwithGoogle();
                  await FirebaseService.saveUserInfo();
                  FirebaseService.writeData();
                  
                  print("Login Successful");
                  Navigator.of(context).pushReplacement(
                    CupertinoPageRoute(
                      builder: (context) => HomePage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

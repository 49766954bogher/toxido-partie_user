import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uber_clone/Authrntification/auth.dart';
import 'package:uber_clone/Connection/connection.dart';
// ignore: unused_import
import 'package:uber_clone/EcranPrincipal/main_screen.dart';
import 'package:uber_clone/Global/global.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  startTimer() {
    Timer(const Duration(seconds: 3), () async {
      if (fAuth.currentUser != null) {
        currentUser = fAuth.currentUser;

        Navigator.push(
            context, MaterialPageRoute(builder: (c) => const MainScreen()));
      } else {
        Navigator.push(context, MaterialPageRoute(builder: (c) => SignUp()));
      }

      Navigator.push(
          context, MaterialPageRoute(builder: (c) => const Connection()));
    });
  }

  @override
  // la ùethode qui sera premier a executer losque user est dans la home screen
  void initState() {
    super.initState();
    startTimer();
  }

  // Ce que  user va observer
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.yellow,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/logo.png',
              ),
              const SizedBox(height: 8.0),
              const Text(
                "Taxi Service",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.black54,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

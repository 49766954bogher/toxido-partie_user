import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:uber_clone/Global/global.dart';
import 'package:uber_clone/Pages/accueil.dart';

import '../Authrntification/authentification.dart';
import '../Connection/connecter.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  startTimer() {
    Timer(const Duration(seconds: 8), () async {
      //if (FirebaseAuth.instance.currentUser == null){
      //     ? const Connection()
      //   : const HomePage(),
      //}

      if (fAuth.currentUser != null) {
        currentUser = fAuth.currentUser;

        Navigator.push(
            context, MaterialPageRoute(builder: (c) => const HomePage()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => const Connecter()));
      }

      //Navigator.push(
      //  context, MaterialPageRoute(builder: (c) => const Connecter()));
    });
  }

  @override
  // la methode qui sera premier a execu
  //ter losque user est dans la home screen
  void initState() {
    super.initState();
    startTimer();
  }

  // Ce que  user va observer
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 250.0,
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Padding(padding: EdgeInsets.all(8.0)),
              Image.asset(
                "images/homeTaxi.png",
                width: MediaQuery.of(context).size.width,
                height: 350.0,
              ),
              const SizedBox(height: 8.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Bienvenue",
                    style: TextStyle(
                        fontSize: 40,
                        fontFamily: "bolt-regular",
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

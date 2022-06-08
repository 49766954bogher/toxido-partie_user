import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:uber_clone/Connection/connection.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

import 'package:uber_clone/Pages/accueil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MyApp(
      child: MaterialApp(
        title: "Taxi servce",
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: AnimatedSplashScreen(
            backgroundColor: Colors.white,
            splash: 'images/logo.png',
            splashIconSize: 200,
            nextScreen: FirebaseAuth.instance.currentUser == null
                ? const Connection()
                : const HomePage()),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}

// Using last version avec nulSafety
class MyApp extends StatefulWidget {
  final Widget? child;

  const MyApp({this.child});
// La methode qui va etr appeler dans n'importe quel place pour redemarer lapp
  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_MyAppState>()!.restartApp();
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child!,
    );
  }
}

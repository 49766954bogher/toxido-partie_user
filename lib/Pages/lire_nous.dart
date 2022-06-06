import 'package:flutter/material.dart';
import 'package:uber_clone/Pages/accueil.dart';

class AproposDeNous extends StatefulWidget {
  const AproposDeNous({Key? key}) : super(key: key);

  @override
  State<AproposDeNous> createState() => _AproposDeNousState();
}

class _AproposDeNousState extends State<AproposDeNous> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("A propos de nous "),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => const HomePage()));
          },
        ),
      ),
      body: const Center(
        child: Text(
          " Nous aimons flutter",
          style: TextStyle(
            fontSize: 25,
            color: Colors.black54,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
    );
  }
}

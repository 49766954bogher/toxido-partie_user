import 'package:flutter/material.dart';

class ChoixBooking extends StatelessWidget {
  const ChoixBooking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const Text(
          "Bienvenue au taxi service",
          style: TextStyle(color: Colors.black54, fontFamily: "bolt-regular"),
        ),
        Container(
            padding: const EdgeInsets.all(30.0),
            child: GridView.count(
              crossAxisCount: 2,
              children: const <Widget>[],
            )),
      ],
    ));
  }
}

class Monchoix extends StatelessWidget {
  const Monchoix(
      {required this.title, required this.icons, required this.couleur});

  final String title;
  final IconData icons;
  final MaterialColor couleur;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.yellowAccent,
      margin: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {},
        splashColor: Colors.blueAccent,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(
                icons,
                size: 70,
                color: couleur,
              ),
              Text(title,
                  style: const TextStyle(fontSize: 17, color: Colors.black54))
            ],
          ),
        ),
      ),
    );
  }
}

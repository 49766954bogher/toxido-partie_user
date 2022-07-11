import 'package:flutter/material.dart';

import 'accueil.dart';
import 'note.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Historique ",
          style: TextStyle(fontSize: 12),
        ),
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
        actions: [
          OutlinedButton.icon(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const NotePage()));
            },
            label: const Text(""),
            icon: const Icon(
              Icons.star_outline_sharp,
              color: Colors.white,
            ),
          ),
        ],
        backgroundColor: Colors.black54,
      ),
      body: Container(),
    );
  }
}

import 'dart:ui';

import 'package:flutter/material.dart';

import 'faire_course.dart';

class infosClient extends StatelessWidget {
  final ListePassagers client;

  const infosClient({Key? key, required this.client}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 1,
          backgroundColor: Colors.black54,
          elevation: 1,
          leading: const BackButton(color: Colors.white),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 80),
          child: Center(
            child: Column(
              children: <Widget>[
                CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.black54,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 78,
                    child: Text(
                      client.nom[0],
                      style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 50),
                    ),
                  ),
                ),
                Text(
                  client.nom,
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  client.email,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 5),
                Text(
                  " Depart au: " + '' + client.depart,
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 5),
                Text(
                  "Arrivée a: " + '' + client.destination,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ));
  }
}

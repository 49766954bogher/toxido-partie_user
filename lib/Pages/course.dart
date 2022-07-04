import 'dart:html';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class _Data extends State {
  List<String> passagers = ["diallo", "sow", "ba", "amadou", "sidi"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        elevation: 0,
      ),
      body: Container(
        child: ListView.builder(
          itemBuilder: (_, int index) => listedonnee(),
          itemCount: this.passagers.length,
        ),
      ),
    );
  }
}

class listedonnee extends StatelessWidget {
  String? nom;
  String? email;
  String? destination;
  String? depart;

  listedonne(String nom, String email, String destination, String depart) {
    this.nom = nom;
    this.email = email;
    this.destination = destination;
    this.depart = depart;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      child: Container(
        margin: const EdgeInsets.all(9.0),
        padding: const EdgeInsets.all(6.0),
        child: Row(
          children: <Widget>[
            CircleAvatar(
              radius: 20,
              child: Text(nom![0]),
            ),
            const Padding(padding: EdgeInsets.all(8.0)),
            Text(
              nom!,
              style: const TextStyle(fontSize: 25),
            )
          ],
        ),
      ),
    );
  }
}

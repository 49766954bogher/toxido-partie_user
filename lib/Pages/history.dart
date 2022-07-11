import 'package:flutter/material.dart';

import 'accueil.dart';
import 'note.dart';

class HistoryPage extends StatelessWidget {
  final List<ListePassagers> passagers = [
    const ListePassagers(
        //ibrhima

        nom: 'Ibrahima',
        email: 'ibrahidiallo300@gmail.com',
        destination: 'ksar',
        depart: 'bmd'),

    //chouaib
    const ListePassagers(
        //Chouaib
        nom: 'Ibrahima',
        email: 'ibrahidiallo300@gmail.com',
        destination: 'iscae',
        depart: 'madrid'),

    const ListePassagers(
        //Mimi

        nom: 'Ibrahima',
        email: 'ibrahidiallo300@gmail.com',
        destination: 'premier',
        depart: 'arafat'),

    const ListePassagers(
        //salma

        nom: 'Ibrahima',
        email: 'ibrahidiallo300@gmail.com',
        destination: 'pk',
        depart: 'iscae'),

    const ListePassagers(
        //salma

        nom: 'Ibrahima',
        email: 'ibrahidiallo300@gmail.com',
        destination: 'iscae',
        depart: 'bmd'),
    const ListePassagers(
        //salma

        nom: 'Ibrahima',
        email: 'ibrahidiallo300@gmail.com',
        destination: 'basra',
        depart: 'ksar'),
    const ListePassagers(
        //salma

        nom: 'Ibrahima',
        email: 'ibrahidiallo300@gmail.com',
        destination: 'arafat',
        depart: 'iscae'),
  ];

  HistoryPage({Key? key}) : super(key: key);

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
      body: ListView.builder(
        itemCount: passagers.length,
        itemBuilder: ((BuildContext context, int index) {
          final client = passagers[index];

          return Card(
            margin: const EdgeInsets.all(8.0),
            // padding:const EdgeInsets.all(5.0),
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.yellowAccent,
                radius: 25,
                child: Text(
                  client.nom[0],
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              ),
              title: Text(client.nom),
              subtitle: buildItem(client.depart, client.destination),
              trailing: const Icon(
                Icons.star_outline,
                color: Colors.white,
              ),
            ),
          );
        }),
      ),
    );
  }
}

Widget buildItem(start, end) => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(start),
        Text(end),
      ],
    );

class ListePassagers {
  final String nom;
  final String email;
  final String destination;
  final String depart;

  const ListePassagers(
      {required this.nom,
      required this.email,
      required this.destination,
      required this.depart});
}

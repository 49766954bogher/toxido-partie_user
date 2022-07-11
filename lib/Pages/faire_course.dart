import 'package:flutter/material.dart';

import 'accueil.dart';

class FaireCourse extends StatefulWidget {
  const FaireCourse({Key? key}) : super(key: key);

  @override
  State<FaireCourse> createState() => _FaireCourseState();
}

class _FaireCourseState extends State<FaireCourse>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
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
        destination: 'arafat',
        depart: '24'),

    const ListePassagers(
        //Mimi
        nom: 'Ibrahima',
        email: 'ibrahidiallo300@gmail.com',
        destination: 'madrid',
        depart: 'fst'),

    const ListePassagers(
        //salma
        nom: 'Ibrahima',
        email: 'ibrahidiallo300@gmail.com',
        destination: 'pk',
        depart: 'arafat'),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 1,
        backgroundColor: Colors.black54,
        elevation: 1,
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
              subtitle: Text(client.depart, semanticsLabel: client.destination),
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

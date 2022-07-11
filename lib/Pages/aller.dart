import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../BoiteGialogue/dialogue.dart';
import '../Pages/accueil.dart';

class PrendreCourse extends StatefulWidget {
  const PrendreCourse({Key? key}) : super(key: key);

  @override
  State<PrendreCourse> createState() => _PrendreCourseState();
}

class _PrendreCourseState extends State<PrendreCourse> {
  TextEditingController depart = TextEditingController();
  TextEditingController arriver = TextEditingController();

  bool showPassword = true;
  bool estPassword = true;

  validationForm() {}

  sauvegarderInfosConnection() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c) {
          return BoiteDeDialogue(message: 'veuillez patienter...');
        });
  }

  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text("Prendre une course"),
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
          backgroundColor: Colors.black54,
        ),
        body: Form(
          child: ListView(
            padding: EdgeInsets.all(15),
            children: [
              const Image(
                  image: AssetImage(
                    "images/pikupLocation.png",
                  ),
                  height: 250,
                  width: double.infinity,
                  alignment: Alignment.center),
              const SizedBox(height: 32),
              const SizedBox(height: 16),
              buildStart(),
              const SizedBox(height: 32),
              buildDestination(),
              const SizedBox(height: 16),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  print("deja partie");
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                /*
                child: Text(
          text,
          style: TextStyle(fontSize: 24),
        ),
        shape: StadiumBorder(),
        color: Theme.of(context).primaryColor,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        textColor: Colors.white,
        onPressed: onClicked,
      );
                  
                  */
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  child: const Center(
                    child: Text(
                      "Terminer",
                      style: TextStyle(
                        fontFamily: 'bolt-regular',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildStart() => TextFormField(
        controller: depart,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
          labelText: 'Depart',
          border: OutlineInputBorder(),
        ),
      );

  Widget buildDestination() => TextFormField(
        controller: arriver,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        decoration: const InputDecoration(
          labelText: 'Arriver',
          border: OutlineInputBorder(),
        ),
      );
}

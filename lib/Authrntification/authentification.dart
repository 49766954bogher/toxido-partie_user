import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uber_clone/Connection/connecter.dart';

import '../BoiteGialogue/dialogue.dart';
import '../Connection/connection.dart';
import '../Global/global.dart';

class Authentification extends StatefulWidget {
  const Authentification({Key? key}) : super(key: key);

  @override
  State<Authentification> createState() => _AuthentificationState();
}

class _AuthentificationState extends State<Authentification> {
  final mykey = GlobalKey<FormState>();

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  validationForm() {
    if (name.text.length < 3) {
      Fluttertoast.showToast(
          msg: "le nom doit avoir au moins trois caracteres");
    } else if (email.text.contains("@")) {
      Fluttertoast.showToast(msg: "email est valide ");
    } else if (phone.text.isEmpty) {
      Fluttertoast.showToast(msg: "le mot de passe doit pas etre null");
    } else if (password.text.length < 6) {
      Fluttertoast.showToast(
          msg: "mot de passe doit contenir au moins 6 caracteres");
    } else {
      sauvegarderInfosChauffeur();
    }
  }

  sauvegarderInfosChauffeur() async {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext c) {
          return BoiteDeDialogue(message: 'veuillez patienter...');
        });

    final User? firebaseUser = (await fAuth
        .createUserWithEmailAndPassword(
            email: email.text.trim(), password: password.text.trim())
        .then((value) {
      return value.user;
    }).catchError((msg) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Erreur, lors de creation d'une compte");
    }));
    // enregistrer dans firebase apres la creation de chauffeur

    if (firebaseUser != null) {
      // ignore: non_constant_identifier_names
      Map MapsChaufeurs = {
        "ID": firebaseUser.uid,
        "name": name.text.trim(),
        "email": email.text.trim(),
        "phone": phone.text.trim(),
        "password": password.text.trim()
      };

      DatabaseReference chauffeurRef =
          FirebaseDatabase.instance.ref().child("user");
      chauffeurRef.child(firebaseUser.uid).set(MapsChaufeurs);
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "votre compte a été bien créer");
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Veuilez crée une compte");

      currentUser = firebaseUser;
    }
  }

  Widget build(BuildContext context) => Scaffold(
        body: Form(
          child: ListView(
            padding: const EdgeInsets.all(15),
            children: [
              const Image(
                  height: 270,
                  width: 250,
                  image: AssetImage(
                    "images/logo.png",
                  ),
                  alignment: Alignment.center),
              const SizedBox(height: 8),
              buildUsername(),
              const SizedBox(height: 32),
              buildEmail(),
              const SizedBox(height: 32),
              buildPhone(),
              const SizedBox(height: 32),
              buildPassword(),
              const SizedBox(height: 16),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  validationForm();
                  sauvegarderInfosChauffeur();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 55,
                  child: const Center(
                    child: Text(
                      "S'inscrire",
                      style: TextStyle(
                          fontFamily: 'bolt-regular',
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              TextButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => const Connecter()));
                },
                child: const Center(
                  child: Text("Avez vous deja une compte, cliquer ici !",
                      style: TextStyle(
                        color: Colors.black,
                      )),
                ),
              ),
              const SizedBox(height: 25.0),
            ],
          ),
        ),
      );

  Widget buildUsername() => TextFormField(
        controller: name,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.person),
          labelText: 'Nom',
          border: OutlineInputBorder(),
        ),
      );

  Widget buildEmail() => TextFormField(
        controller: email,
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.email),
          labelText: 'Email',
          border: OutlineInputBorder(),
        ),
      );
  Widget buildPhone() => TextFormField(
        controller: phone,
        keyboardType: TextInputType.phone,
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
          prefixIcon: Icon(Icons.phone),
          labelText: 'Telephone',
          border: OutlineInputBorder(),
        ),
      );

  bool estPassword = true;
  bool VoirPassword = false;

  Widget buildPassword() => TextFormField(
        controller: password,
        keyboardType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.done,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          suffixIcon: estPassword
              ? IconButton(
                  onPressed: () {
                    // ignore: unused_element
                    void setState() {
                      VoirPassword = !VoirPassword;
                    }
                  },
                  icon: const Icon(
                    Icons.remove_red_eye,
                  ),
                )
              : null,
          labelText: 'Mot de passe',
          border: const OutlineInputBorder(),
        ),
        obscureText: true,
      );
}

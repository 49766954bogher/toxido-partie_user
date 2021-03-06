import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uber_clone/Connection/connection.dart';

import 'package:uber_clone/Global/global.dart';

import '../BoiteGialogue/dialogue.dart';

// ignore: use_key_in_widget_constructors
class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  validationForm() {
    if (name.text.length < 3) {
      Fluttertoast.showToast(
          msg: "le nom doit avoir au moins trois caracteres");
    } else if (email.text.contains("@")) {
      Fluttertoast.showToast(msg: "email doit contenir un @");
    } else if (phone.text.isEmpty) {
      Fluttertoast.showToast(msg: "le passe de passe doit pas etre null");
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
      Fluttertoast.showToast(msg: "Error, lors de creation d'un compte");
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
      Fluttertoast.showToast(msg: "votre compte a ??t?? bien creer");
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Veuilez cr??e une compte");

      currentUser = firebaseUser;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Image(
                image: AssetImage(
                  "images/logo.png",
                ),
                height: 270,
                width: 250,
                alignment: Alignment.center),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: Column(children: [
                TextField(
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  controller: name,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                  decoration: InputDecoration(
                      labelText: "Nom",
                      hintText: "Nom",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Colors.yellow,
                          width: 3.0,
                        ),
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 18)),
                ),
                TextFormField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                  decoration: InputDecoration(
                      labelText: "Email",
                      hintText: "email",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Colors.yellow,
                          width: 3.0,
                        ),
                      ),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      labelStyle:
                          const TextStyle(color: Colors.grey, fontSize: 18)),
                ),
                TextFormField(
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  controller: phone,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                  decoration: InputDecoration(
                      labelText: "Telephone",
                      hintText: "telephone",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Colors.yellow,
                          width: 3.0,
                        ),
                      ),
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      labelStyle:
                          const TextStyle(color: Colors.grey, fontSize: 18)),
                ),
                TextField(
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  controller: password,
                  obscureText: true,
                  obscuringCharacter: "*",
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                  decoration: const InputDecoration(
                      labelText: "Mot de passe",
                      hintText: "mot de passe",
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)),
                      hintStyle: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 18)),
                ),
                const SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {
                    validationForm();
                    sauvegarderInfosChauffeur();
                    Fluttertoast.showToast(msg: "Compte bien cr??e");
                  },
                  /*
                  style: ElevatedButton.styleFrom(
                    primary: Colors.yellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                  ),
                  */
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    color: Colors.yellowAccent,
                    child: const Center(
                      child: Text(
                        "S'inscrire",
                        style: TextStyle(
                          fontFamily: 'bolt-regular',
                          fontSize: 18,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (c) => const Connection()));
              },
              child: const Center(
                child: Text("Avez vous deja une compte, cliquer ici !",
                    style: TextStyle(
                      color: Colors.grey,
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

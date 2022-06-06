import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../Authrntification/auth.dart';
import '../BoiteGialogue/dialogue.dart';
import '../Global/global.dart';
import '../Pages/accueil.dart';

class Connection extends StatefulWidget {
  const Connection({Key? key}) : super(key: key);

  @override
  State<Connection> createState() => _ConnectionState();
}

class _ConnectionState extends State<Connection> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  validationForm() {
    if (email.text.contains("@")) {
      Fluttertoast.showToast(msg: "Email est valid");
    } else if (password.text.isNotEmpty) {
      Fluttertoast.showToast(msg: "Mot de passe est valide ");
    } else {
      sauvegarderInfosConnection();
    }
  }

  sauvegarderInfosConnection() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c) {
          return BoiteDeDialogue(message: 'veuillez patienter...');
        });

    final User? firebaseUser = (await fAuth
            .signInWithEmailAndPassword(
                email: email.text.trim(), password: password.text.trim())
            .catchError((msg) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error de creation de compte");
    }))
        .user;

    // enregistrer dans firebase apres la creation de chauffeur

    if (firebaseUser != null) {
      currentUser = firebaseUser;
      Fluttertoast.showToast(msg: "Bienvenue");
      Navigator.push(
          context, MaterialPageRoute(builder: (c) => const HomePage()));
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(
          msg: "erreur de mot de passe ou nom d'utilisateur ");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Column(
            children: [
              const Image(
                  image: AssetImage("images/logo.png"),
                  height: 300,
                  width: 250,
                  alignment: Alignment.center),
              const SizedBox(height: 1.0),
              const Text(
                "Se connecter",
                style: TextStyle(
                    fontSize: 0,
                    color: Colors.black,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(children: [
                  TextField(
                    keyboardType: TextInputType.text,
                    controller: email,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                    decoration: const InputDecoration(
                        labelText: "Email utilisatueur",
                        hintText: "email utilisatueur",
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        labelStyle:
                            TextStyle(color: Colors.grey, fontSize: 18)),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  TextField(
                    keyboardType: TextInputType.visiblePassword,
                    obscuringCharacter: "*",
                    obscureText: true,
                    controller: password,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                    decoration: const InputDecoration(
                        labelText: "Mot de passe ",
                        hintText: "mot de passe",
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey)),
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                        labelStyle:
                            TextStyle(color: Colors.grey, fontSize: 18)),
                  ),
                  const SizedBox(
                    height: 18.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      validationForm();
                      sauvegarderInfosConnection();

                      //Navigator.push(context,
                      //MaterialPageRoute(builder: (c) => const HomePage()));
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.yellow,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
                    child: Container(
                      height: 50.0,
                      child: const Center(
                        child: Text(
                          "Se connecter",
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "",
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
                  Navigator.push(
                      context, MaterialPageRoute(builder: (c) => SignUp()));
                },
                child: const Center(
                  child: Text("pas de compte, cliquez ici !",
                      style: TextStyle(
                        color: Colors.grey,
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

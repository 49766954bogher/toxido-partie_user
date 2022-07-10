import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uber_clone/Authrntification/authentification.dart';
import '../BoiteGialogue/dialogue.dart';
import '../Global/global.dart';
import '../Pages/accueil.dart';

class Connecter extends StatefulWidget {
  const Connecter({Key? key}) : super(key: key);

  @override
  State<Connecter> createState() => _ConnecterState();
}

class _ConnecterState extends State<Connecter> {
  TextEditingController password = TextEditingController();
  TextEditingController email = TextEditingController();

  validationForm() {
    if (email.text.contains("@") && (password.text.isNotEmpty)) {
      Fluttertoast.showToast(msg: "Email et Mot de passe sont valide");
      sauvegarderInfosConnection();
    } else {
      Fluttertoast.showToast(msg: "Email et Mot de passe n'ont valide");
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
      Fluttertoast.showToast(msg: "Erreur de creation de compte");
    }))
        .user;

    // enregistrer dans firebase apres la creation de chauffeur

    if (firebaseUser != null) {
      currentUser = firebaseUser;
      Fluttertoast.showToast(msg: "Bienvenue");
      // ignore: use_build_context_synchronously
      Navigator.push(
          context, MaterialPageRoute(builder: (c) => const HomePage()));
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Mot de passe ou email est incorect! ");
    }
  }

  Widget build(BuildContext context) => Scaffold(
        body: Form(
          child: ListView(
            padding: const EdgeInsets.all(15),
            children: [
              const Image(
                  image: AssetImage(
                    "images/logo.png",
                  ),
                  alignment: Alignment.center),
              const SizedBox(height: 8),
              buildEmail(),
              const SizedBox(height: 32),
              buildPassword(),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text(
                    'Mot de passe oublié *',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  validationForm();
                  sauvegarderInfosConnection();
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
                      "Se connecter",
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
                      MaterialPageRoute(builder: (c) => Authentification()));
                },
                child: const Center(
                  child: Text("Pas de compte, cliquez ici !",
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

  bool VoirPassword = false;
  bool estPassword = true;

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
        obscureText: estPassword ? VoirPassword : true,
      );
}

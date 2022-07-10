import 'package:flutter/material.dart';

import 'accueil.dart';

class ProfilePage extends StatelessWidget {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();

  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black54,
        title: const Text("Profile"),
        scrolledUnderElevation: 1,
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
      body: Container(
        padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            //FocusScope.of(context).unfocus();
          },
          child: ListView(children: [
            const Image(
                image: AssetImage(
                  "images/diallo.jpg",
                ),
                height: 180,
                width: double.infinity,
                alignment: Alignment.center),
            const SizedBox(
              height: 15,
            ),
            const SizedBox(
              height: 35,
            ),
            const SizedBox(height: 8),
            buildUsername(),
            const SizedBox(height: 32),
            buildEmail(),
            const SizedBox(height: 32),
            buildPhone(),
            const SizedBox(height: 32),
            buildPassword(),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
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
                    "Enregister",
                    style: TextStyle(
                        fontFamily: 'bolt-regular',
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

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

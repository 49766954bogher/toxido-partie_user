import 'package:flutter/material.dart';

class ChercherPage extends StatefulWidget {
  const ChercherPage({Key? key}) : super(key: key);

  @override
  State<ChercherPage> createState() => _ChercherPageState();
}

class _ChercherPageState extends State<ChercherPage> {
  TextEditingController depart = TextEditingController();
  TextEditingController destination = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 215.0,
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.black,
          blurRadius: 6.0,
          spreadRadius: 0.5,
          offset: Offset(0.7, 0.7),
        ),
      ]),
      child: Padding(
        padding:
            const EdgeInsets.only(left: 25, top: 25, right: 25, bottom: 20),
        child: Column(children: [
          const SizedBox(
            height: 5.0,
          ),
          Stack(
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(
                    context), //Navigator.of(context).push(MaterialPageRoute(
                //builder: (BuildContext context) => const ChercherPage())),
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
              Center(
                child: Text(
                  "Chercher votre localition",
                  style: TextStyle(fontSize: 18),
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Image.asset(
                "images/pickicon.png",
                height: 16,
                width: 16,
              ),
              const SizedBox(height: 18),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: TextField(
                      controller: depart,
                      decoration: InputDecoration(
                        hintText: "Ou etes vous ?",
                        fillColor: Colors.grey[400],
                        filled: true,
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: const EdgeInsets.only(
                            left: 11.0, top: 8.0, bottom: 8.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Image.asset(
                "images/desticon.png",
                height: 16,
                width: 16,
              ),
              const SizedBox(height: 18),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: TextField(
                      controller: destination,
                      decoration: InputDecoration(
                        hintText: "Ou voudrez vous aller?",
                        fillColor: Colors.grey[400],
                        filled: true,
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: const EdgeInsets.only(
                            left: 11.0, top: 8.0, bottom: 8.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}

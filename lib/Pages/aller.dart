import 'package:flutter/material.dart';

import 'accueil.dart';

class PrendreCourse extends StatefulWidget {
  const PrendreCourse({Key? key}) : super(key: key);

  @override
  State<PrendreCourse> createState() => _PrendreCourseState();
}

class _PrendreCourseState extends State<PrendreCourse> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  TextEditingController depart = TextEditingController();
  TextEditingController destination = TextEditingController();

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
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 16, top: 80, right: 16),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Column(children: [
                        const Text(
                          "Prendre courses",
                          style: TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          keyboardType: TextInputType.text,
                          controller: depart,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                          decoration: const InputDecoration(
                              labelText: "Depart",
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
                          controller: destination,
                          style: const TextStyle(
                            color: Colors.grey,
                          ),
                          decoration: const InputDecoration(
                              labelText: "Arriver ",
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
                            //Navigator.push(context,
                            //MaterialPageRoute(builder: (c) => const HomePage()));
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.black54,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24.0),
                            ),
                          ),
                          child: Container(
                            height: 50.0,
                            child: const Center(
                              child: Text(
                                "envoyez",
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
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

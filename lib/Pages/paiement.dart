import 'package:flutter/material.dart';
import 'package:uber_clone/Pages/accueil.dart';

class PaiementPage extends StatefulWidget {
  const PaiementPage({Key? key}) : super(key: key);

  @override
  State<PaiementPage> createState() => _PaiementPageState();
}

class _PaiementPageState extends State<PaiementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Total des paiement",
          style: TextStyle(fontSize: 12),
        ),
        backgroundColor: Colors.white,
        leading: BackButton(color: Colors.black),
      ),
      body: const Center(
        child: Text("nombre des voyages "),
      ),
    );
  }
}

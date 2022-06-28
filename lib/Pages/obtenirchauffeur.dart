import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ontenirChauffuer extends StatefulWidget {
  const ontenirChauffuer({Key? key}) : super(key: key);

  @override
  State<ontenirChauffuer> createState() => _ontenirChauffuerState();
}

class _ontenirChauffuerState extends State<ontenirChauffuer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: BackButton(color: Colors.black),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20),
            const Center(
              child: Text(
                "Coisir un chauffeur",
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            _buildName(
                imageAsset: 'images/taxi.png', name: "Ibrahima", score: 1000),
            SizedBox(height: 20),
            _buildName(
                imageAsset: 'images/taxi.png', name: "Amadou", score: 3000),
            SizedBox(height: 20),
            _buildName(
                imageAsset: 'images/taxi.png', name: "Ahmed", score: 2000),
          ],
        ),
      ),
    );
  }

  Widget _buildName({String? imageAsset, String? name, double? score}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: <Widget>[
          const SizedBox(height: 12),
          Container(height: 2, color: Colors.redAccent),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: AssetImage(imageAsset!),
                radius: 30,
              ),
              const SizedBox(width: 12),
              Text(name!),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                child: Text("${score}"),
                decoration: BoxDecoration(
                  color: Colors.yellow[900],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

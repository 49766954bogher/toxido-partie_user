import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_place/google_place.dart';

import '../Maps/maps.dart';
import '../Pages/accueil.dart';

class ChercherPage extends StatefulWidget {
  const ChercherPage({Key? key}) : super(key: key);

  @override
  State<ChercherPage> createState() => _ChercherPageState();
}

class _ChercherPageState extends State<ChercherPage> {
  final TextEditingController depart = TextEditingController();
  final TextEditingController destination = TextEditingController();

  DetailsResult? startPosition;
  DetailsResult? endPosition;

  late FocusNode startFocusNode;
  late FocusNode endFocusNode;

  late GooglePlace googlePlace;
  List<AutocompletePrediction> predictions = [];
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    String apiKey = 'AIzaSyDNxhlq0YoADTxZ3Be_iMtd_3zWUPe_mpo';
    googlePlace = GooglePlace(apiKey);

    startFocusNode = FocusNode();
    endFocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    startFocusNode.dispose();
    endFocusNode.dispose();
  }

  void autoCompleteSearch(String value) async {
    var result = await googlePlace.autocomplete.get(value);
    if (result != null && result.predictions != null && mounted) {
      print(result.predictions!.first.description);
      setState(() async {
        predictions = result.predictions!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: const BackButton(color: Colors.black),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              controller: depart,
              autofocus: false,
              focusNode: startFocusNode,
              style: const TextStyle(fontSize: 24),
              decoration: InputDecoration(
                  hintText: ' Point de depart ',
                  hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 15),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  suffixIcon: depart.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              predictions = [];
                              depart.clear();
                            });
                          },
                          icon: const Icon(Icons.clear_outlined),
                        )
                      : null),
              onChanged: (value) {
                if (_debounce?.isActive ?? false) _debounce!.cancel();
                _debounce = Timer(const Duration(milliseconds: 1000), () {
                  if (value.isNotEmpty) {
                    //places api
                    // autoCompleteSearch(value);
                  } else {
                    //clear out the results
                    setState(() {
                      predictions = [];
                      startPosition = null;
                    });
                  }
                });
              },
            ),
            const SizedBox(height: 10),
            TextField(
              controller: destination,
              autofocus: false,
              focusNode: endFocusNode,
              // enabled: depart.text.isNotEmpty && startPosition != null,
              style: const TextStyle(fontSize: 24),
              decoration: InputDecoration(
                  hintText: 'Point d\'arrivée',
                  hintStyle: const TextStyle(
                      fontWeight: FontWeight.w500, fontSize: 15),
                  filled: true,
                  fillColor: Colors.grey[200],
                  border: InputBorder.none,
                  suffixIcon: destination.text.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              predictions = [];
                              destination.clear();
                            });
                          },
                          icon: const Icon(Icons.clear_outlined),
                        )
                      : null),
              onChanged: (value) {
                if (_debounce?.isActive ?? false) _debounce!.cancel();
                if (_debounce?.isActive ?? false) _debounce!.cancel();
                _debounce = Timer(const Duration(milliseconds: 1000), () {
                  if (value.isNotEmpty) {
                    //places api
                    //autoCompleteSearch(value);
                  } else {
                    //clear out the results
                    setState(() {
                      predictions = [];
                      endPosition = null;
                    });
                  }
                });
              },
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: predictions.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: const CircleAvatar(
                      child: Icon(
                        Icons.pin_drop,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(
                      predictions[index].description.toString(),
                    ),
                    onTap: () async {
                      final placeId = predictions[index].placeId!;
                      final details = await googlePlace.details.get(placeId);
                      if (details != null &&
                          details.result != null &&
                          mounted) {
                        if (startFocusNode.hasFocus) {
                          setState(() {
                            startPosition = details.result;
                            depart.text = details.result!.name!;
                            predictions = [];
                          });
                        } else {
                          setState(() {
                            endPosition = details.result;
                            destination.text = details.result!.name!;
                            predictions = [];
                          });
                        }

                        if (startPosition != null && endPosition != null) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  const MapScreen()));
                        }
                      }
                    },
                  );
                })
          ],
        ),
      ),
    );
  }
}

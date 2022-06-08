import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uber_clone/Chercher/chercher.dart';
import 'package:uber_clone/Connection/connection.dart';
import 'package:uber_clone/Pages/note.dart';
import 'package:uber_clone/Pages/paiement.dart';
import 'package:uber_clone/Pages/profile.dart';
import 'package:uber_clone/Pages/reglage.dart';
import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Global/global.dart';
import 'history.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController depart = TextEditingController();
  TextEditingController destination = TextEditingController();

  // LatLng _lastPosition = _inialPosition;

  //static const _inialPosition = LatLng(18.0735411, -15.9582337);

  final Completer<GoogleMapController> _controllerGoogleMaps = Completer();
  GoogleMapController? controllerChauffeur;
  GlobalKey<ScaffoldState> scafoldkey = GlobalKey<ScaffoldState>();
  Position? currentPosition;
  var geolocalor = Geolocator();

  void getPositionLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    currentPosition = position;
    LatLng latLatPosition = LatLng(position.latitude, position.longitude);

    CameraPosition cameraPosition =
        CameraPosition(target: latLatPosition, zoom: 14);
    controllerChauffeur!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  // ignore: non_constant_identifier_names
  var Mymarkers = HashSet<Marker>();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(18.0735411, -15.9582337),
    zoom: 15.0,
  );

  //target: LatLng(37.42796133580664, -122.085749655962),

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Accueil",
          style: TextStyle(fontSize: 12),
        ),
        backgroundColor: Colors.black54,
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            mapType: MapType.normal,
            compassEnabled: true,
            myLocationButtonEnabled: true,
            zoomControlsEnabled: true,
            zoomGesturesEnabled: true,
            //onCameraMove: _onCameraMove,
            myLocationEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMaps.complete(controller);
              controllerChauffeur = controller;
              setState(() {
                Mymarkers.add(Marker(
                  markerId: const MarkerId("1"),
                  icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueGreen,
                  ),
                  position: const LatLng(18.0735411, -15.9582337),
                ));
              });

              getPositionLocation();
            },
            initialCameraPosition: _kGooglePlex,
            markers: Mymarkers,
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: Container(
              height: 320.0,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18.0),
                      topRight: Radius.circular(18.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 16.0,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7),
                    ),
                  ]),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      "Bienvenue...",
                      style: TextStyle(fontSize: 15.0),
                    ),
                    const Text(
                      "Ou vouler-vous aller?",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black54,
                              blurRadius: 6.0,
                              spreadRadius: 0.5,
                              offset: Offset(0.7, 0.7),
                            ),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.search,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 16.0,
                            ),
                            Text(
                              "Chercher votre lieu",
                              style: TextStyle(
                                  fontSize: 15.0, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.home,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 12.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Maison ",
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              "Ajouter adresse de votre maison",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Divider(
                      color: Colors.blue,
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.work,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          width: 12.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Bureau",
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              "Lieu de travail",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      drawer: const NavigationDrawer(),
    );
  }
}

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            buildHeader(context),
            buildMenuItems(context),
          ],
        ),
      ),
    );
  }

  Widget buildMenuItems(BuildContext context) => Container(
        color: Colors.white,
        padding: const EdgeInsets.all(24),
        child: Wrap(
          runSpacing: 16,
          children: [
            ListTile(
                leading: const Icon(Icons.home),
                title: const Text("Accueil"),
                onTap: () {
                  //Navigator.pop(context);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const HomePage()));
                }),
            ListTile(
                leading: const Icon(Icons.search),
                title: const Text("Course "),
                onTap: () {
                  //Navigator.pop(context);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const ChercherPage()));
                }),
            ListTile(
                leading: const Icon(Icons.credit_card_outlined),
                title: const Text("Paiement"),
                onTap: () {
                  //Navigator.pop(context);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const PaiementPage()));
                }),
            ListTile(
                leading: const Icon(Icons.star),
                title: const Text("Note"),
                onTap: () {
                  //Navigator.pop(context);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const NotePage()));
                }),
            ListTile(
                leading: const Icon(Icons.person),
                title: const Text("Compte"),
                onTap: () {
                  //Navigator.pop(context);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const ProfilePage()));
                }),
            const Divider(
              color: Colors.black54,
              thickness: 1.0,
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Reglage"),
              onTap: () {
                //Navigator.pop(context);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const PageReglage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text("Historique"),
              onTap: () {
                //Navigator.pop(context);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const HistoryPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app),
              title: const Text("Deconnecter"),
              onTap: () async {
                await fAuth.signOut();
                //Navigator.pop(context);
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => const Connection()));
              },
            ),
          ],
        ),
      );

  Widget buildHeader(BuildContext context) => Material(
        color: Colors.black45,
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(left: 16, top: 35, right: 16),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => const ProfilePage()));
            },
            child: Column(
              children: const [
                CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.yellow,
                  child: CircleAvatar(
                    radius: 78,
                    backgroundImage: AssetImage(
                      "images/brms.jpg",
                    ),
                  ),
                ),
                SizedBox(height: 12.0),
                Text(
                  "Utilisateur",
                  style: TextStyle(color: Colors.black54),
                ),
                Text('brms@gmail.com', style: TextStyle(color: Colors.black)),
              ],
            ),
          ),
        ),
      );
}

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:uber_clone/Connection/connection.dart';
import 'package:uber_clone/Pages/note.dart';

import 'package:uber_clone/Pages/profile.dart';
import 'dart:async';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Global/global.dart';

import 'aller.dart';
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
      key: scafoldkey,
      body: Stack(
        children: <Widget>[
          GoogleMap(
            mapType: MapType.normal,
            compassEnabled: true,
            myLocationButtonEnabled: false,
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
            },
            initialCameraPosition: _kGooglePlex,
            markers: Mymarkers,
          ),
          Positioned(
            top: 35,
            left: 20,
            child: FloatingActionButton(
              heroTag: "menu",
              onPressed: () {
                scafoldkey.currentState?.openDrawer();
              },
              tooltip: "Menu",
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.menu,
                color: Colors.black,
              ),
            ),
          ),
          Positioned(
            top: 95,
            left: 20,
            child: FloatingActionButton(
              heroTag: 'location',
              onPressed: () {
                getPositionLocation();
              },
              tooltip: "Location",
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.location_on_outlined,
                color: Colors.black,
              ),
            ),
          ),
          Positioned(
            left: 0.0,
            right: 0.0,
            bottom: 0.0,
            child: Container(
              height: 350.0,
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
                      "Chercher un lieu!",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                const PrendreCourse()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                            boxShadow: const [
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
                                color: Colors.blueAccent,
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
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.home,
                          color: Colors.blueAccent,
                        ),
                        const SizedBox(
                          width: 12.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Maison ",
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              "Dar El Barké Ntt-Mrt",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    const Divider(
                      color: Colors.black45,
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.work,
                          color: Colors.blueAccent,
                        ),
                        const SizedBox(
                          width: 12.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text(
                              "Bureau",
                            ),
                            SizedBox(
                              height: 4.0,
                            ),
                            Text(
                              "ISCAE",
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
      backgroundColor: Colors.black54,
      child: ListView(
        children: <Widget>[
          const UserAccountsDrawerHeader(
            accountName: Text(
              "Ibrahima diallo",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
            ),
            accountEmail: Text("ibrahima@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage(
                "images/diallo.jpg",
              ),
            ),
            decoration: BoxDecoration(
              //fit: BoxFit.cover,
              color: Colors.black54,
            ),
          ),
          //buildHeader(context),
          buildMenuItems(context),
        ],
      ),
    );
  }

  Widget buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          runSpacing: 16,
          children: [
            ListTile(
                leading: const Icon(Icons.person),
                title: const Text("Profile"),
                onTap: () {
                  //Navigator.pop(context);
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => ProfilePage()));
                }),
            ListTile(
                leading: const Icon(Icons.star),
                title: const Text("Note"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const NotePage()));
                }),
            ListTile(
              leading: const Icon(Icons.car_repair),
              title: const Text("Demander une course"),
              onTap: () {
                //Navigator.pop(context);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const PrendreCourse()));
              },
            ),
            const Divider(
              color: Colors.black54,
              thickness: 1.0,
            ),
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text("Historique"),
              onTap: () {
                //Navigator.pop(context);
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => HistoryPage()));
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
                  builder: (BuildContext context) => ProfilePage()));
            },
            child: Column(
              children: const [
                CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.yellow,
                  child: CircleAvatar(
                    radius: 78,
                    backgroundImage: AssetImage(
                      "images/diallo.jpg",
                    ),
                  ),
                ),
                SizedBox(height: 12.0),
                Text(
                  "Utilisateur",
                  style: TextStyle(color: Colors.black54),
                ),
                Text('ibrahima@gmail.com',
                    style: TextStyle(color: Colors.black)),
              ],
            ),
          ),
        ),
      );
}

Widget build(BuildContext context) {
  var status;
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      const Text("theme"),
      const SizedBox(
        height: 12.0,
      ),
      Text(
        'Value : $status',
        style: const TextStyle(color: Colors.black, fontSize: 20.0),
      ),
    ],
  );
}

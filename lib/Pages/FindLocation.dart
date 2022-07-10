import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class findLocation extends StatefulWidget {
  late final String long;
  late final String lat;
  findLocation({required this.long, required this.lat});
  @override
  State<findLocation> createState() => _findLocationState();
}

class _findLocationState extends State<findLocation> {
  GoogleMapController? _controller;
  Set<Marker> _markers = {};
  List<Polyline> myploy = [];
  double funclong() {
    double result = double.parse('${widget.long}');
    return result;
  }

  double funclat() {
    double result = double.parse('${widget.lat}');
    return result;
  }

  void getLocation() async {
    _controller
        ?.animateCamera(CameraUpdate.newCameraPosition(new CameraPosition(
      target: LatLng(funclat(), funclong()),
      zoom: 18.0,
    )));
    print(funclong().toString());
    print("lllllll" + widget.long.toString());
    print(funclat().toString());
    print("lllllll" + widget.lat.toString());
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId('Home'), position: LatLng(funclat(), funclong())));
    });
  }

  creatpolyline() async {
    var currentLocation;
    var location = await currentLocation.getLocation();
    myploy.add(
      Polyline(
          polylineId: PolylineId('1'),
          color: Colors.teal,
          width: 3,
          points: [
            LatLng(location.latitude ?? 0.0, location.longitude ?? 0.0),
            LatLng(funclat(), funclong())
          ]),
    );
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      creatpolyline();
      getLocation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyPosition"),
        centerTitle: true,
        backgroundColor: Colors.cyan,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GoogleMap(
          zoomControlsEnabled: false,
          initialCameraPosition: CameraPosition(
            target: LatLng(funclat(), funclong()),
            zoom: 12.0,
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller = controller;
          },
          markers: _markers,
          polylines: myploy.toSet(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              child: Icon(Icons.add_location_alt),
              backgroundColor: Colors.cyan,
              onPressed: () {
                //displayTextInput(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              child: Icon(Icons.menu),
              backgroundColor: Colors.cyan,
              onPressed: () {
                // bottumsheet(context);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              child: Icon(Icons.telegram),
              backgroundColor: Colors.cyan,
              onPressed: () {
                //displayTextInputDR(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}

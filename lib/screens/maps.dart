import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../services/database.dart';
import 'home.dart';

class MapsLocation extends StatefulWidget {
  static const routeName = '/map';
  final String spotName;
  const MapsLocation({Key? key, required this.spotName}) : super(key: key);

  @override
  _MapsLocationState createState() => _MapsLocationState();
}

class _MapsLocationState extends State<MapsLocation> {
  late GoogleMapController mapController;

  late LatLng _currentLatLng;

  @override
  void initState() {
    Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.best,
            forceAndroidLocationManager: true)
        .then((Position position) {
      setState(() {
        print('GOTT LOCATION!!!');
        _currentLatLng = LatLng(position.latitude, position.longitude);
      });
    }).catchError((e) {
      print(e);
      setState(() {
        _currentLatLng = const LatLng(19.018255973653343, 72.84793849278007);
      });
    });
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Set<Marker> _createMarker() {
    return {
      Marker(
        markerId: const MarkerId("marker_1"),
        position: _currentLatLng,
      ),
    };
  }

  void _updateMarker(LatLng argument) {
    debugPrint('$argument');
    setState(() {
      _currentLatLng = argument;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Maps',
          textAlign: TextAlign.center,
        ),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _currentLatLng,
          zoom: 11.0,
        ),
        markers: _createMarker(),
        onTap: (argument) => _updateMarker(argument),
        onLongPress: (argument) => _updateMarker(argument),
      ),
      floatingActionButton: Row(
        children: [
          const SizedBox(width: 40),
          FloatingActionButton(
            onPressed: () async {
              //   List<Placemark> placemarks = await placemarkFromCoordinates(
              //       _currentLatLng.latitude, _currentLatLng.longitude);
              //   print(placemarks.toString());
              try {
                await DatabaseService.createSpots(
                    location: _currentLatLng, name: widget.spotName);
                Navigator.pushReplacementNamed(context, HomePage.routeName);
              } catch (e) {
                debugPrint(e.toString());
              }
            },
            child: const Icon(CupertinoIcons.forward),
          ),
        ],
      ),
    );
  }
}

import 'dart:async';

import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:flutter_project/pages/edit/new_question.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GoogleMapsPage extends StatefulWidget {
  @override
  _GoogleMapsPageState createState() => _GoogleMapsPageState();
}

class _GoogleMapsPageState extends State<GoogleMapsPage> {
  double longitude = 0;
  double latitude = 0;
  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = HashSet<Marker>();
  bool onLocation = false;

  int _markerIdCounter = 1;

  static final CameraPosition _kThomasMore = CameraPosition(
    target: LatLng(51.16101, 4.96146),
    zoom: 12,
  );

  void _setMarkers(LatLng point, BitmapDescriptor color) {
    final String markerIdVal = 'marker_id_$_markerIdCounter';
    _markerIdCounter++;
    setState(() {
      _markers.add(
        Marker(
          markerId: MarkerId(markerIdVal),
          position: point,
          icon: color,
        ),
      );
      latitude = point.latitude;
      longitude = point.longitude;
      onLocation = true;
    });
  }

  _checkLocationPermission() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
  }

  Future<void> _goToPoint(CameraPosition point) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(point));
  }

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
    _startLocation();
  }

  _startLocation() async {
    await location.getLocation().then((value) {
      _goToPoint(
        CameraPosition(
          zoom: 17,
          tilt: 45,
          target: LatLng(
            value.latitude,
            value.longitude,
          ),
        ),
      );
    });
  }

  navigatePage() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => NewQuestionPage(0, longitude, latitude)),
    ).then((value) => Navigator.pop(context));
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff21254A),
        title: Text("Waypoint"),
      ),
      backgroundColor: Color(0xff21254A),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kThomasMore,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: _markers,
        myLocationEnabled: true,
        onTap: (point) {
          setState(() {
            _markers.clear();
            _setMarkers(point, BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue));
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Visibility(
        child: FloatingActionButton.extended(
          onPressed: () {
            navigatePage();
          },
          backgroundColor: Color(0xff21254A),
          label: Text('Question?'),
        ),
        visible: onLocation,
      ),
    );
  }
}

import 'dart:async';

import 'dart:collection';
import 'package:augmented_reality_plugin_wikitude/wikitude_plugin.dart';
import 'package:augmented_reality_plugin_wikitude/wikitude_response.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/apis/question_api.dart';
import 'package:flutter_project/apis/route_api.dart';
import 'package:flutter_project/models/question.dart';
import 'package:flutter_project/pages/play/ARPOI.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geodesy/geodesy.dart' as Geo;
import 'package:location/location.dart';
import 'package:prefs/prefs.dart';

class GoogleMapsPage extends StatefulWidget {
  @override
  _GoogleMapsPageState createState() => _GoogleMapsPageState();
}

class _GoogleMapsPageState extends State<GoogleMapsPage> {
  List<String> features = ["image_tracking", "geo"];
  Location location = new Location();

  bool _serviceEnabled;
  PermissionStatus _permissionGranted;

  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = HashSet<Marker>();
  bool onLocation = false;

  int _markerIdCounter = 1;

  List<Question> questions = List<Question>();
  LatLng nextQuestion;

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
    });
  }

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
    _startLocationLogging();
    _apiCalls();
  }

  _apiCalls() async {
    _markers.clear();
    _markerIdCounter = 1;
    QuestionApi.getRouteQuestions(Prefs.getString("routeId")).then((questions) {
      this.questions = questions;
      RouteApi.getPlayedQuestions(
              Prefs.getString("id"), Prefs.getString("routeId"))
          .then((playedquestions) {
        int total = playedquestions.length;
        this.questions.asMap().forEach((index, question) {
          var color =
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange);
          if (index == 0 && questions.length == total) {
            _goToPoint(
              CameraPosition(
                zoom: 17,
                tilt: 45,
                target: LatLng(
                  double.parse(questions[index].location.split(";")[0]),
                  double.parse(questions[index].location.split(";")[1]),
                ),
              ),
            );
          }
          if (index < total && question.answer == playedquestions[index].answer)
            color = BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueGreen);
          else if (index < total &&
              question.answer != playedquestions[index].answer)
            color =
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed);
          else if (index == total) {
            color =
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue);
            nextQuestion = LatLng(
              double.parse(questions[index].location.split(";")[0]),
              double.parse(questions[index].location.split(";")[1]),
            );
            Prefs.setString("questionId", questions[index].id.toString());
            _goToPoint(
              CameraPosition(
                zoom: 17,
                tilt: 45,
                target: LatLng(
                  double.parse(questions[index].location.split(";")[0]),
                  double.parse(questions[index].location.split(";")[1]),
                ),
              ),
            );
          }
          _setMarkers(
            LatLng(double.parse(question.location.split(";")[0]),
                double.parse(question.location.split(";")[1])),
            color,
          );
        });
      });
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

  _startLocationLogging() async {
    await location.getLocation();
    location.onLocationChanged.listen((LocationData currentLocation) {
      if (nextQuestion.latitude > 0) {
        Geo.Geodesy geodesy = Geo.Geodesy();
        num distance = geodesy.distanceBetweenTwoGeoPoints(
          Geo.LatLng(currentLocation.latitude, currentLocation.longitude),
          Geo.LatLng(nextQuestion.latitude, nextQuestion.longitude),
        );
        if (distance < 10) {
          setState(() {
            onLocation = true;
          });
        } else {
          setState(() {
            onLocation = false;
          });
        }
      }
    });
  }

  Future<void> _goToPoint(CameraPosition point) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(point));
  }

  navigatePage() {
    this.checkDeviceCompatibility().then((value) {
        if (value.success) {
          this.requestARPermissions().then((value) {
              if (value.success) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ArPOIWidget()),
                ).then((value) => _apiCalls());
              }
            },
          );
        }
      },
    );
  }

  Future<WikitudeResponse> checkDeviceCompatibility() async {
    return await WikitudePlugin.isDeviceSupporting(this.features);
  }

  Future<WikitudeResponse> requestARPermissions() async {
    return await WikitudePlugin.requestARPermissions(this.features);
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: Visibility(
        child: FloatingActionButton.extended(
          onPressed: () {
            navigatePage();
          },
          backgroundColor: Color(0xff21254A),
          label: Text('Find object'),
        ),
        visible: onLocation,
      ),
    );
  }
}

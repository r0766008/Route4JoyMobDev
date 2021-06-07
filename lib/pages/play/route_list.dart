import 'package:flutter/material.dart';
import 'package:flutter_project/apis/route_api.dart';
import 'package:flutter_project/models/route.dart' as MyRoute;
import 'package:flutter_project/pages/play/google_maps.dart';
import 'package:prefs/prefs.dart';

class RouteListPage extends StatefulWidget {
  @override
  _RouteListPageState createState() => _RouteListPageState();
}

class _RouteListPageState extends State<RouteListPage> {
  List<MyRoute.Route> routes = List<MyRoute.Route>();

  navigatePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GoogleMapsPage()),
    );
  }

  @override
  void initState() {
    super.initState();
    RouteApi.getRoutes().then((value) {
      setState(() {
        routes = value;
      });
    });
  }

  routeList() {
    if (routes.length == 0)
      return Center(child: CircularProgressIndicator());
    else {
      return ListView.builder(
        itemCount: routes.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                Prefs.setString("routeId", routes[index].id.toString());
                navigatePage();
              },
              title: Text(routes[index].name),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff21254A),
        title: Text("All Routes"),
      ),
      backgroundColor: Color(0xff21254A),
      body: Container(
        child: routeList(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_project/apis/route_api.dart';
import 'package:flutter_project/models/route.dart' as MyRoute;
import 'package:flutter_project/pages/edit/question_list.dart';
import 'package:flutter_project/pages/edit/new_route.dart';
import 'package:prefs/prefs.dart';

class RouteListPage extends StatefulWidget {
  @override
  _RouteListPageState createState() => _RouteListPageState();
}

class _RouteListPageState extends State<RouteListPage> {
  List<MyRoute.Route> routes = List<MyRoute.Route>();
  bool none = false;

  navigatePage(String page) {
    if (page == "Questions") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => QuestionListPage()),
      ).then((value) => refresh());
    } else if (page == "New Route") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NewRoutePage(0)),
      ).then((value) => refresh());
    }
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  refresh() {
    RouteApi.getUserRoutes(Prefs.getString("id")).then((value) {
      if (value == null) {
        setState(() {
          none = true;
        });
      } else {
        setState(() {
          none = false;
          routes = value;
        });
      }
    });
  }

  routeList() {
    if (routes.length == 0 && !none)
      return Center(child: CircularProgressIndicator());
    else if (routes.length > 0 && !none) {
      return ListView.builder(
        itemCount: routes.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                Prefs.setString("routeId", routes[index].id.toString());
                navigatePage("Questions");
              },
              title: Text(routes[index].name),
            ),
          );
        },
      );
    } else {
      return Align(
        alignment: Alignment.center,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 60.0),
          child: Text(
            "No routes found yet, you can create a new one.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff21254A),
        title: Text("My Routes"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          navigatePage("New Route");
        },
        tooltip: "Add new Route",
        child: new Icon(Icons.add),
      ),
      backgroundColor: Color(0xff21254A),
      body: Container(
        child: routeList(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_project/apis/route_api.dart';
import 'package:flutter_project/models/route.dart' as MyRoute;
import 'package:flutter_project/widgets/input_field.dart';
import 'package:prefs/prefs.dart';

class NewRoutePage extends StatefulWidget {
  final int routeId;
  NewRoutePage(this.routeId);

  @override
  _NewRoutePageState createState() => _NewRoutePageState(routeId);
}

class _NewRoutePageState extends State<NewRoutePage> {
  int routeId;
  _NewRoutePageState(this.routeId);

  String title = "New Route";
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController city = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  
  MyRoute.Route route = new MyRoute.Route();

  onSubmit() {
    if (_formKey.currentState.validate()) {
      route.id = routeId;
      route.userId = int.parse(Prefs.getString("id"));
      RouteApi.newRoute(route).then((value) {
        if (value != null) {
          Navigator.pop(context);
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (routeId != 0) {
       title = "Edit Route";
       RouteApi.getCurrentRoute(Prefs.getString("routeId")).then((value) {
        route.name = value[0].name;
        route.description = value[0].description;
        route.country = value[0].country;
        route.city = value[0].city;
        setState(() {
          name.text = value[0].name;
          description.text = value[0].description;
          country.text = value[0].country;
          city.text = value[0].city;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff21254A),
        title: Text(title),
      ),
      backgroundColor: Color(0xff21254A),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.transparent,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          InputFieldWidget(
                            controller: name,
                            fieldName: "Name",
                            onValueChanged: (value) {
                              route.name = value;
                            },
                          ),
                          InputFieldWidget(
                            controller: description,
                            fieldName: "Description",
                            onValueChanged: (value) {
                              route.description = value;
                            },
                          ),
                          InputFieldWidget(
                            controller: country,
                            fieldName: "Country",
                            onValueChanged: (value) {
                              route.country = value;
                            },
                          ),
                          InputFieldWidget(
                            controller: city,
                            fieldName: "City",
                            onValueChanged: (value) {
                              route.city = value;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      onSubmit();
                    },
                    child: Container(
                      height: 50,
                      margin: EdgeInsets.symmetric(horizontal: 60),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Color.fromRGBO(124, 40, 194, 1),
                      ),
                      child: Center(
                        child: Text(
                          "Submit",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

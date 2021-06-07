import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_project/apis/authentication_api.dart';
import 'package:flutter_project/models/stat.dart';
import 'package:flutter_project/widgets/maindrawer.dart';
import 'package:prefs/prefs.dart';

class ProfileUIPage extends StatefulWidget {
  @override
  _ProfileUIState createState() => _ProfileUIState();
}

class _ProfileUIState extends State<ProfileUIPage> {
  Stat stat = Stat();

  @override
  void initState() {
    super.initState();
    AuthenticationApi.getStats(Prefs.getString("id")).then((value) {
      setState(() {
        stat = value;
      });
    });
  }

  userStats() {
    if (stat.total == null) {
      return Column(
        children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          Center(child: CircularProgressIndicator()),
          SizedBox(
            height: 10.0,
          ),
        ],
      );
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 22.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                children: <Widget>[
                  Text(
                    "Total",
                    style: TextStyle(
                      color: Color(0xff21254A),
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    stat.total.toString(),
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Color.fromRGBO(124, 40, 194, 1),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Text(
                    "Correct",
                    style: TextStyle(
                      color: Color(0xff21254A),
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    stat.correct.toString(),
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Color.fromRGBO(124, 40, 194, 1),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: <Widget>[
                  Text(
                    "Wrong",
                    style: TextStyle(
                      color: Color(0xff21254A),
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    stat.wrong.toString(),
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Color.fromRGBO(124, 40, 194, 1),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff21254A),
        title: Text("My Profile"),
      ),
      drawer: Drawer(
        child: MainDrawer(),
      ),
      body: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                  Color(0xff21254A),
                  Color.fromRGBO(124, 40, 194, 1)
                ])),
            child: Container(
              width: double.infinity,
              height: 350.0,
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        "https://i.stack.imgur.com/l60Hf.png",
                      ),
                      radius: 50.0,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      Prefs.getString("first_name") +
                          " " +
                          Prefs.getString("last_name"),
                      style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Card(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
                      clipBehavior: Clip.antiAlias,
                      color: Colors.white,
                      elevation: 5.0,
                      child: userStats(),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("First Name"),
                SizedBox(height: 4),
                Text(Prefs.getString("first_name")),
                SizedBox(height: 16),
                Text("Last Name"),
                SizedBox(height: 4),
                Text(Prefs.getString("last_name")),
                SizedBox(height: 16),
                Text("Username"),
                SizedBox(height: 4),
                Text(Prefs.getString("username")),
                SizedBox(height: 16),
                Text("Email"),
                SizedBox(height: 4),
                Text(Prefs.getString("email")),
                SizedBox(height: 16),
                Text("Joined since"),
                SizedBox(height: 4),
                Text(Prefs.getString("joined_since")),
                SizedBox(height: 16),
                Divider(
                  color: Colors.grey,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

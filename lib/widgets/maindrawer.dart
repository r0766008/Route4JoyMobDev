import 'package:flutter/material.dart';
import 'package:flutter_project/pages/dashboard.dart';
import 'package:flutter_project/pages/profile/profile_ui.dart';
import 'package:flutter_project/pages/authentication/sign_in.dart';
import 'package:prefs/prefs.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  onNavigate(page) {
    Navigator.pop(context);
    Navigator.pop(context);
    switch (page) {
      case "Profile":
        {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfileUIPage()),
          );
        }
        break;

      default:
        {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DashboardPage()),
          );
        }
        break;
    }
  }

  onLogout() async {
    Prefs.clear();
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignInPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        child: Padding(
          padding: EdgeInsets.only(top: 50.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50.0,
                backgroundImage: NetworkImage(
                  "https://i.stack.imgur.com/l60Hf.png",
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                Prefs.getString("first_name") + " " + Prefs.getString("last_name"),
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                Prefs.getString("username"),
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
      SizedBox(
        height: 20.0,
      ),
      ListTile(
        onTap: () {
          onNavigate("Dashboard");
        },
        leading: Icon(
          Icons.assessment,
          color: Colors.black,
        ),
        title: Text("My Dashboard"),
      ),
      ListTile(
        onTap: () {
          onNavigate("Profile");
        },
        leading: Icon(
          Icons.person,
          color: Colors.black,
        ),
        title: Text("My Profile"),
      ),
      ListTile(
        onTap: () {
          onLogout();
        },
        leading: Icon(
          Icons.logout,
          color: Colors.black,
        ),
        title: Text("Logout"),
      ),
    ]);
  }
}

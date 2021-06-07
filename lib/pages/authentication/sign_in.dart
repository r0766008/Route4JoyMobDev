import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project/pages/dashboard.dart';
import 'package:prefs/prefs.dart';

import 'package:flutter_project/models/authenticate.dart';

import 'package:flutter_project/pages/authentication/sign_up.dart';
import 'package:flutter_project/pages/authentication/forgot_password.dart';

import 'package:flutter_project/apis/authentication_api.dart';

import 'package:flutter_project/widgets/input_field.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();

  Authenticate user = new Authenticate();

  loggedIn() async {
    await Prefs.init();
    if (Prefs.getString("id").toString() != "") {
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => DashboardPage()),
      );
    }
  }

  onLogin() {
    if (_formKey.currentState.validate()) {
      AuthenticationApi.loginUser(user).then((value) {
        if (value != null) {
          Prefs.setString("id", jsonDecode(value)["id"]);
          Prefs.setString("first_name", jsonDecode(value)["first_name"]);
          Prefs.setString("last_name", jsonDecode(value)["last_name"]);
          Prefs.setString("username", jsonDecode(value)["username"]);
          Prefs.setString("email", jsonDecode(value)["email"]);
          Prefs.setString("joined_since", jsonDecode(value)["joined_since"]);
          Navigator.pop(context);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DashboardPage()),
          );
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff21254A),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 200,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("assets/images/header.png"),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Hello there, \nwelcome back",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
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
                            fieldName: "Email",
                            onValueChanged: (value) {
                              user.email = value;
                            },
                          ),
                          InputFieldWidget(
                            fieldName: "Password",
                            isPassword: true,
                            onValueChanged: (value) {
                              user.password = value;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPasswordPage()),
                      );
                    },
                    child: Center(
                      child: Text(
                        "Forgot Password",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      onLogin();
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
                          "Login",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUpPage()),
                      );
                    },
                    child: Center(
                      child: Text(
                        "Create Account",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
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

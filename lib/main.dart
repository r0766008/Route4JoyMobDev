import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_project/pages/authentication/sign_in.dart';

void main() => runApp(new UserManagementApp());

class UserManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Project',
      theme: new ThemeData(
        primarySwatch: Colors.red,
      ),
      home: SignInPage(),
    );
  }
}

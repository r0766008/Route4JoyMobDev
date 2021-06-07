import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project/models/authenticate.dart';
import 'package:flutter_project/models/stat.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import '../models/user.dart';

class AuthenticationApi {
  static String baseUrl = 'https://procode.be/account/';

  static Future<User> registerUser(User user) async {
    final response =
        await http.post(baseUrl + "register/", body: user.toJson());

    if (response.statusCode == 200)
      return user;
    else {
      String message;
      if (response.statusCode == 404)
        message = "Something went wrong, please try again later";
      else
        message = "Email is already in use";
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    return null;
  }

  static Future<String> loginUser(Authenticate user) async {
    final response = await http.post(baseUrl + "login/", body: user.toJson());

    String message;
    if (response.statusCode == 200) {
      if (response.body.contains("Error_Auth") && response.body.contains("inactive"))
        message = "This account is still inactive";
      else if (response.body.contains("Error_Auth") && response.body.contains("Incorrect"))
        message = "Email/Password is incorrect";
      else if (response.body.contains("Error_Auth") && response.body.contains("Locked Out"))
        message = "You are temporarily locked out, try again later";
      else
        return response.body;
    } else
      message = "Something went wrong, please try again later";
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    return null;
  }

  static Future<String> forgotPassword(String email) async {
    final response =
        await http.post(baseUrl + "forgot/", body: {'email': email});

    String message;
    if (response.statusCode == 200) {
      if (response.body.contains("Success"))
        return email;
      else
        message = "This email is not in our system";
    } else
      message = "Something went wrong, please try again later";
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
    return null;
  }

  static Future<Stat> getStats(String userId) async {
    final response =
        await http.post(baseUrl + "getstats/", body: {'UserId': userId});

    if (response.statusCode == 200) {
      var stat = json.decode(response.body)["Stats"];
      return Stat.fromJson(stat);
    } else {
      String message = "Something went wrong, please try again later";
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    return null;
  }
}

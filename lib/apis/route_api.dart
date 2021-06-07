import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project/models/route.dart' as MyRoute;
import 'package:flutter_project/models/played_question.dart';
import 'package:flutter_project/models/stat.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class RouteApi {
  static String baseUrl = 'https://procode.be/route/';

  static Future<List<MyRoute.Route>> getRoutes() async {
    final response =
        await http.post(baseUrl + "routes/");

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((route) => new MyRoute.Route.fromJson(route)).toList();
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

  static Future<List<MyRoute.Route>> getUserRoutes(String userId) async {
    final response =
        await http.post(baseUrl + "userroutes/", body: { "UserId": userId });

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      if (jsonResponse.length == 0) return null;
      return jsonResponse.map((route) => new MyRoute.Route.fromJson(route)).toList();
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

  static Future<List<MyRoute.Route>> getCurrentRoute(String routeId) async {
    final response =
        await http.post(baseUrl + "currentroute/", body: { "RouteId": routeId });
        
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      if (jsonResponse.length == 0) return null;
      return jsonResponse.map((route) => new MyRoute.Route.fromJson(route)).toList();
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

  static Future<List<PlayedQuestion>> getPlayedQuestions(String userId, String routeId) async {
    final response =
        await http.post(baseUrl + "playedquestions/", body: { "UserId": userId, "RouteId": routeId });

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((playedquestion) => new PlayedQuestion.fromJson(playedquestion)).toList();
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
  
  static Future<String> newRoute(MyRoute.Route route) async {
    final response =
        await http.post(baseUrl + "newroute/", body: route.toJson());

    String message;
    if (response.statusCode == 200) {
      if (response.body.contains("Error_Route"))
        message = "This route name already exists";
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

  static Future<Stat> getStats(String userId, String routeId) async {
    final response =
        await http.post(baseUrl + "getstats/", body: {'UserId': userId, 'RouteId': routeId});

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
  
  static Future<String> deleteRoute(String routeId) async {
    final response =
        await http.post(baseUrl + "deleteroute/", body: {"RouteId": routeId});

    String message;
    if (response.statusCode == 200) {
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
}

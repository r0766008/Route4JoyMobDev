import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project/models/question.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class QuestionApi {
  static String baseUrl = 'https://procode.be/question/';

  static Future<List<Question>> getCurrentQuestion(String id) async {
    final response =
        await http.post(baseUrl + "currentquestion/", body: { "QuestionId": id });

    if (response.statusCode == 200) {
      List questions = json.decode(response.body)["Question"];
      return questions.map((question) => new Question.fromJson(question)).toList();
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

  static Future<List<Question>> getRouteQuestions(String id) async {
    final response =
        await http.post(baseUrl + "routequestions/", body: { "RouteId": id });

    if (response.statusCode == 200) {
      List questions = json.decode(response.body)["Questions"];
      if (questions.length == 0) return null;
      return questions.map((question) => new Question.fromJson(question)).toList();
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
  
  static Future<String> newQuestion(Question question) async {
    final response =
        await http.post(baseUrl + "newquestion/", body: question.toJson());

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
  
  static Future<String> deleteQuestion(String questionId) async {
    final response =
        await http.post(baseUrl + "deletequestion/", body: {"QuestionId": questionId});

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

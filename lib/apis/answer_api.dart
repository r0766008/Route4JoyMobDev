import 'package:flutter/material.dart';
import 'package:flutter_project/models/answer.dart';
import 'package:flutter_project/models/played_question.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class AnswerApi {
  static String baseUrl = 'https://procode.be/answer/';

  static Future<String> newAnswer(Answer answer) async {
    final response =
        await http.post(baseUrl + "newanswer/", body: answer.toJson());

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

  static Future<String> setPlayedQuestion(PlayedQuestion playedQuestion) async {
    final response =
        await http.post(baseUrl + "playedquestion/", body: playedQuestion.toJson());

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

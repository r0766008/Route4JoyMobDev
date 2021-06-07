import 'package:flutter/material.dart';
import 'package:flutter_project/apis/answer_api.dart';
import 'package:flutter_project/apis/question_api.dart';
import 'package:flutter_project/apis/route_api.dart';
import 'package:flutter_project/models/played_question.dart';
import 'package:flutter_project/models/question.dart';
import 'package:flutter_project/models/stat.dart';
import 'package:flutter_project/models/route.dart' as MyRoute;
import 'package:prefs/prefs.dart';

class QuestionPage extends StatefulWidget {
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  Stat stat = Stat();
  List<Question> question = List<Question>();
  List<MyRoute.Route> routes = List<MyRoute.Route>();

  @override
  void initState() {
    super.initState();
    _apiCalls();
  }

  _apiCalls() async {
    RouteApi.getCurrentRoute(Prefs.getString("routeId")).then((value) {
      setState(() {
        routes = value;
      });
    });
    RouteApi.getStats(Prefs.getString("id"), Prefs.getString("routeId")).then((value) {
      setState(() {
        stat = value;
      });
    });
    QuestionApi.getCurrentQuestion(Prefs.getString("questionId")).then((value) {
      setState(() {
        question = value;
      });
    });
  }

  postAnswer(int number) {
    PlayedQuestion playedQuestion = new PlayedQuestion();
    playedQuestion.userId = int.parse(Prefs.getString("id"));
    playedQuestion.routeId = int.parse(Prefs.getString("routeId"));
    playedQuestion.questionId = int.parse(Prefs.getString("questionId"));
    playedQuestion.answer = number;
    AnswerApi.setPlayedQuestion(playedQuestion).then((value) {
      //toast
      Navigator.pop(context);
    });
  }

  routeQuestion() {
    if (question.length == 0 || routes.length == 0 || stat.total == null)
      return Center(child: CircularProgressIndicator());
    else {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              height: 125,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0)),
                color: Color.fromRGBO(124, 40, 194, 1),
              ),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: Text(
                      routes[0].name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Text(
                          "Correct: " + stat.correct.toString(),
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Score: "  + stat.correct.toString() + "/" + stat.total.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "Wrong: " + stat.wrong.toString(),
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Text(
              question[0].question,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 20),
            ),
            SizedBox(
              height: 50,
            ),
            GestureDetector(
              onTap: () {
                postAnswer(question[0].answers[0].number);
              },
              child: Container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                      bottomLeft: Radius.circular(40.0),
                      topLeft: Radius.circular(40.0)),
                  color: Color.fromRGBO(124, 40, 194, 1),
                ),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        color: Color(0xff21254A),
                      ),
                      child: Center(
                        child: Text(
                          "A",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Flexible(
                      child: Text(
                        question[0].answers[0].answer,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                postAnswer(question[0].answers[1].number);
              },
              child: Container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                      bottomLeft: Radius.circular(40.0),
                      topLeft: Radius.circular(40.0)),
                  color: Color.fromRGBO(124, 40, 194, 1),
                ),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        color: Color(0xff21254A),
                      ),
                      child: Center(
                        child: Text(
                          "B",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Flexible(
                      child: Text(
                        question[0].answers[1].answer,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                postAnswer(question[0].answers[2].number);
              },
              child: Container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                      bottomLeft: Radius.circular(40.0),
                      topLeft: Radius.circular(40.0)),
                  color: Color.fromRGBO(124, 40, 194, 1),
                ),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        color: Color(0xff21254A),
                      ),
                      child: Center(
                        child: Text(
                          "C",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Flexible(
                      child: Text(
                        question[0].answers[2].answer,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                postAnswer(question[0].answers[3].number);
              },
              child: Container(
                height: 50,
                margin: EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                      bottomLeft: Radius.circular(40.0),
                      topLeft: Radius.circular(40.0)),
                  color: Color.fromRGBO(124, 40, 194, 1),
                ),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 30,
                      width: 30,
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        color: Color(0xff21254A),
                      ),
                      child: Center(
                        child: Text(
                          "D",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Flexible(
                      child: Text(
                        question[0].answers[3].answer,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
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
        title: Text("Question"),
      ),
      backgroundColor: Color(0xff21254A),
      body: routeQuestion(),
    );
  }
}

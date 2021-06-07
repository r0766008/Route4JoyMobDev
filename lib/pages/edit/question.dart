import 'package:flutter/material.dart';
import 'package:flutter_project/apis/question_api.dart';
import 'package:flutter_project/models/question.dart';
import 'package:flutter_project/pages/edit/new_question.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:prefs/prefs.dart';

class QuestionPage extends StatefulWidget {
  @override
  _QuestionPageState createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  List<Question> question = List<Question>();

  @override
  void initState() {
    super.initState();
    _apiCalls();
  }

  _apiCalls() async {
    QuestionApi.getCurrentQuestion(Prefs.getString("questionId")).then((value) {
      setState(() {
        question = value;
      });
    });
  }

  deleteQuestion() {
    QuestionApi.deleteQuestion(Prefs.getString("questionId")).then((value) {
      Navigator.pop(context);
    });
  }

  navigatePage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewQuestionPage(int.parse(Prefs.getString("questionId")), double.parse(question[0].location.split(";")[1]), double.parse(question[0].location.split(";")[0]))),
    ).then((value) => _apiCalls());
  }

  routeQuestion() {
    if (question.length == 0)
      return Center(child: CircularProgressIndicator());
    else {
      return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
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
                //Gesture
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
                //Gesture
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
                //Gesture
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
                //Gesture
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
      floatingActionButton: SpeedDial(
        marginRight: 18,
        marginBottom: 20,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.black,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
            child: Icon(Icons.edit),
            backgroundColor: Colors.orange,
            label: 'Edit',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              navigatePage();
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.delete),
            backgroundColor: Colors.red,
            label: 'Delete',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              deleteQuestion();
            },
          ),
        ],
      ),
      backgroundColor: Color(0xff21254A),
      body: routeQuestion(),
    );
  }
}

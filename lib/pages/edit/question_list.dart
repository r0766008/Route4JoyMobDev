import 'package:flutter/material.dart';
import 'package:flutter_project/apis/question_api.dart';
import 'package:flutter_project/apis/route_api.dart';
import 'package:flutter_project/models/question.dart';
import 'package:flutter_project/pages/edit/google_maps.dart';
import 'package:flutter_project/pages/edit/new_route.dart';
import 'package:flutter_project/pages/edit/question.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:prefs/prefs.dart';

class QuestionListPage extends StatefulWidget {
  @override
  _QuestionListPageState createState() => _QuestionListPageState();
}

class _QuestionListPageState extends State<QuestionListPage> {
  List<Question> questions = List<Question>();
  bool none = false;

  navigatePage(String page) {
    if (page == "View Question") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => QuestionPage()),
      ).then((value) => refresh());
    } else if (page == "New Question") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => GoogleMapsPage()),
      ).then((value) => refresh());
    } else if (page == "Edit Route") {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => NewRoutePage(int.parse(Prefs.getString("routeId")))),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    refresh();
  }

  deleteRoute() {
    RouteApi.deleteRoute(Prefs.getString("routeId")).then((value) {
      Navigator.pop(context);
    });
  }

  refresh() {
    QuestionApi.getRouteQuestions(Prefs.getString("routeId")).then((value) {
      if (value == null) {
        setState(() {
          none = true;
        });
      } else {
        setState(() {
          none = false;
          questions = value;
        });
      }
    });
  }

  questionList() {
    if (questions.length == 0 && !none)
      return Center(child: CircularProgressIndicator());
    else if (questions.length > 0 && !none) {
      return ListView.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () {
                Prefs.setString("questionId", questions[index].id.toString());
                navigatePage("View Question");
              },
              title: Text(questions[index].question.toString()),
            ),
          );
        },
      );
    } else {
      return Align(
        alignment: Alignment.center,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 60.0),
          child: Text(
            "No questions found yet, you can create a new one.",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff21254A),
        title: Text("Route Questions"),
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
            child: Icon(Icons.add),
            backgroundColor: Colors.green,
            label: 'New',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              navigatePage("New Question");
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.edit),
            backgroundColor: Colors.orange,
            label: 'Edit',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              navigatePage("Edit Route");
            },
          ),
          SpeedDialChild(
            child: Icon(Icons.delete),
            backgroundColor: Colors.red,
            label: 'Delete',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              deleteRoute();
            },
          ),
        ],
      ),
      backgroundColor: Color(0xff21254A),
      body: Container(
        child: questionList(),
      ),
    );
  }
}

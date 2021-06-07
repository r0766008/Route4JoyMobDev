import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project/apis/question_api.dart';
import 'package:flutter_project/apis/answer_api.dart';
import 'package:flutter_project/models/answer.dart';
import 'package:flutter_project/models/question.dart';
import 'package:flutter_project/widgets/input_field.dart';
import 'package:prefs/prefs.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

class NewQuestionPage extends StatefulWidget {
  final double longitude;
  final double latitude;
  final int questionId;
  NewQuestionPage(this.questionId, this.longitude, this.latitude);

  @override
  _NewQuestionPageState createState() =>
      _NewQuestionPageState(questionId, longitude, latitude);
}

class _NewQuestionPageState extends State<NewQuestionPage> {
  int questionId;
  double longitude;
  double latitude;
  _NewQuestionPageState(this.questionId, this.longitude, this.latitude);

  String _rightAnswer = '1';
  String title = "New Question";
  TextEditingController questionInput = TextEditingController();
  TextEditingController answer1 = TextEditingController();
  TextEditingController answer2 = TextEditingController();
  TextEditingController answer3 = TextEditingController();
  TextEditingController answer4 = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Question question = new Question();
  List<Answer> answers = new List<Answer>();

  @override
  void initState() {
    super.initState();
    answers.add(new Answer());
    answers.add(new Answer());
    answers.add(new Answer());
    answers.add(new Answer());
    question.answer = 1;
    if (questionId != 0) {
       title = "Edit Question";
       QuestionApi.getCurrentQuestion(Prefs.getString("questionId")).then((value) {
        question.question = value[0].question;
        question.answer = value[0].answer;
        answers[0].id = value[0].answers[0].id;
        answers[1].id = value[0].answers[1].id;
        answers[2].id = value[0].answers[2].id;
        answers[3].id = value[0].answers[3].id;
        answers[0].number = value[0].answers[0].number;
        answers[1].number = value[0].answers[1].number;
        answers[2].number = value[0].answers[2].number;
        answers[3].number = value[0].answers[3].number;
        answers[0].answer = value[0].answers[0].answer;
        answers[1].answer = value[0].answers[1].answer;
        answers[2].answer = value[0].answers[2].answer;
        answers[3].answer = value[0].answers[3].answer;
        setState(() {
          questionInput.text = value[0].question;
          _rightAnswer = value[0].answer.toString();
          answer1.text = value[0].answers[0].answer;
          answer2.text = value[0].answers[1].answer;
          answer3.text = value[0].answers[2].answer;
          answer4.text = value[0].answers[3].answer;
        });
      });
    } else {
        answers[0].id = 0;
        answers[1].id = 0;
        answers[2].id = 0;
        answers[3].id = 0;
        answers[0].number = 1;
        answers[1].number = 2;
        answers[2].number = 3;
        answers[3].number = 4;
    }
  }

  onSubmit() {
    if (_formKey.currentState.validate()) {
      question.id = questionId;
      question.routeId = int.parse(Prefs.getString("routeId"));
      question.location = latitude.toString() + ";" + longitude.toString();
      QuestionApi.newQuestion(question).then((value) {
        int count = 0;
        answers.forEach((element) {
          if (questionId != 0) element.questionId = int.parse(json.decode(value)["Success"][0]["id"]);
          else element.questionId = questionId;
          AnswerApi.newAnswer(element).then((value) {
            count++;
            if (value != null && count == 4) {
              Navigator.pop(context);
            }
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff21254A),
        title: Text(title),
      ),
      backgroundColor: Color(0xff21254A),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
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
                              controller: questionInput,
                              fieldName: "Question",
                              onValueChanged: (value) {
                                question.question = value;
                              },
                            ),
                            InputFieldWidget(
                              controller: answer1,
                              fieldName: "Answer 1",
                              onValueChanged: (value) {
                                answers[0].routeId =
                                    int.parse(Prefs.getString("routeId"));
                                answers[0].answer = value;
                              },
                            ),
                            InputFieldWidget(
                              controller: answer2,
                              fieldName: "Answer 2",
                              onValueChanged: (value) {
                                answers[1].routeId =
                                    int.parse(Prefs.getString("routeId"));
                                answers[1].answer = value;
                              },
                            ),
                            InputFieldWidget(
                              controller: answer3,
                              fieldName: "Answer 3",
                              onValueChanged: (value) {
                                answers[2].routeId =
                                    int.parse(Prefs.getString("routeId"));
                                answers[2].answer = value;
                              },
                            ),
                            InputFieldWidget(
                              controller: answer4,
                              fieldName: "Answer 4",
                              onValueChanged: (value) {
                                answers[3].routeId =
                                    int.parse(Prefs.getString("routeId"));
                                answers[3].answer = value;
                              },
                            ),
                            Theme(
                              data: new ThemeData(
                                textTheme: TextTheme(
                                  subtitle1: TextStyle(color: Colors.grey),
                                ),
                                canvasColor: Color(0xff21254A),
                                primaryColor: Colors.grey,
                                hintColor: Colors.grey,
                              ),
                              child: DropDownFormField(
                                titleText: 'Right answer',
                                hintText: 'Choose the right answer',
                                value: _rightAnswer,
                                onChanged: (value) {
                                  setState(() {
                                    _rightAnswer = value;
                                    question.answer = int.parse(value);
                                  });
                                },
                                dataSource: [
                                  {
                                    "display": "Answer 1",
                                    "value": "1",
                                  },
                                  {
                                    "display": "Answer 2",
                                    "value": "2",
                                  },
                                  {
                                    "display": "Answer 3",
                                    "value": "3",
                                  },
                                  {
                                    "display": "Answer 4",
                                    "value": "4",
                                  },
                                ],
                                textField: 'display',
                                valueField: 'value',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        onSubmit();
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
                            "Submit",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

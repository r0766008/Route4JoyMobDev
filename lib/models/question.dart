import 'package:flutter_project/models/answer.dart';

class Question {
  int id;
  int routeId;
  String question;
  String location;
  int answer;
  List<Answer> answers;

  Question({this.id, this.routeId, this.question, this.location, this.answer, this.answers});

  factory Question.fromJson(Map<String, dynamic> jsonData) {
    List answers = jsonData['answers'];
    var answerList = answers.map((answer) => new Answer.fromJson(answer)).toList();
    return Question(
      id: int.parse(jsonData['id']),
      routeId: int.parse(jsonData['route_id']),
      question: jsonData['question'],
      location: jsonData['location'],
      answer: int.parse(jsonData['answer']),
      answers: answerList
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'route_id': routeId.toString(),
        'question': question,
        'location': location,
        'answer': answer.toString()
      };
}

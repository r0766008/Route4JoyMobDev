class Answer {
  int id;
  int questionId;
  int routeId;
  int number;
  String answer;

  Answer({this.id, this.questionId, this.routeId, this.number, this.answer});

  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      id: int.parse(json['id']),
      questionId: int.parse(json['question_id']),
      routeId: int.parse(json['route_id']),
      number: int.parse(json['number']),
      answer: json['answer'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'question_id': questionId.toString(),
        'route_id': routeId.toString(),
        'number': number.toString(),
        'answer': answer
      };
}

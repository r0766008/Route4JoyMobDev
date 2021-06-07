class PlayedQuestion {
  int id;
  int userId;
  int routeId;
  int questionId;
  int answer;

  PlayedQuestion({this.id, this.userId, this.routeId, this.questionId, this.answer});

  factory PlayedQuestion.fromJson(Map<String, dynamic> jsonData) {
    return PlayedQuestion(
      id: int.parse(jsonData['id']),
      userId: int.parse(jsonData['user_id']),
      routeId: int.parse(jsonData['route_id']),
      questionId: int.parse(jsonData['question_id']),
      answer: int.parse(jsonData['answer'])
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'user_id': userId.toString(),
        'route_id': routeId.toString(),
        'question_id': questionId.toString(),
        'answer': answer.toString()
      };
}

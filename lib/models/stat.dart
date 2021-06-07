class Stat {
  int total;
  int correct;
  int wrong;

  Stat({this.total, this.correct, this.wrong});

  factory Stat.fromJson(Map<String, dynamic> json) {
    return Stat(
      total: int.parse(json['total']),
      correct: int.parse(json['correct']),
      wrong: int.parse(json['wrong']),
    );
  }

  Map<String, dynamic> toJson() => {
        'total': total.toInt(),
        'correct': correct.toInt(),
        'wrong': wrong.toInt()
      };
}

class Question {
  String _soru;
  String _a;
  String _b;
  String _c;
  String _d;
  String _answer;
  String secilen;

  Question(Map question) {
    if (question.length != 6) {
      //throw Exception;
    }
    secilen = question["secilen"];
    _soru = question["soru"];
    _answer = question[question["cevap"]];
    _a = question["a"];
    _b = question["b"];
    _c = question["c"];
    _d = question["d"];
  }

  String get a => _a;
  String get b => _b;
  String get c => _c;
  String get d => _d;

  String get soru => _soru;
  String get answer => _answer;

  static List<Question> questions;
}

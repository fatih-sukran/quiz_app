import 'question_modal.dart';

class QuestionList {
  final List<Question> questions;

  QuestionList({this.questions});
  factory QuestionList.fromJson(List<Map> parsedJson) {
    List<Question> questions = List<Question>();
    questions = parsedJson.map((i) => Question(i)).toList();

    return QuestionList(questions: questions);
  }

  static QuestionList questionList = QuestionList();
}

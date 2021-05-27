import 'package:quiz_app/modal/question_modal.dart';

import 'status.dart';

class Quiz {
  int _score = 0;
  int _index = 0;
  int _trues = 0;
  int _falses = 0;
  int _can = 3;

  Status status = Status.loss;

  int get trues => _trues;
  int get falses => _falses;
  int get index => _index;
  int get can => _can;
  int get score => _score;

  void control(Question question) {
    if (question.secilen == Question.questions[_index].answer) {
      _score += 10;
      _trues++;
      status = Status.win;
    } else {
      _falses++;
      _can--;
      status = Status.loss;
    }
  }

  bool passNextQuestion() {
    print("passNextQuestion ::: _can : $_can");
    if ((_index == Question.questions.length - 1) ||
        (_can <= 0)) {
      return false;
    }

    _index++;
    return true;
  }
}

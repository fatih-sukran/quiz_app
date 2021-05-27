import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import 'package:quiz_app/modal/question_modal.dart';

Future<String> _loadQuestionAsset(int level) async {
  return await rootBundle.loadString('assets/questions/level$level.json');
}

Future<List<Question>> loadQuestions(int level) async {
  String jsonString = await _loadQuestionAsset(level);
  var parsedJson = json.decode(jsonString) as List;
  return parsedJson.map((question) => Question(question)).toList();
}
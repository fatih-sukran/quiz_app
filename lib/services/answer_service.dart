import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

Future<String> _loadAnswerAsset(int level) async {
  return await rootBundle.loadString('assets/answers/level$level.json');
}

Future<List<String>> loadAnswer(int level) async {
  String jsonString = await _loadAnswerAsset(level);
  return json.decode(jsonString);
}
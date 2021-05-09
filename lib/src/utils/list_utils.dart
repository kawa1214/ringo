import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:ringo/src/data/dictionary.dart';
import 'package:ringo/src/data/word.dart';

class ListUtils {
  static saveList(List<int> list, String path) {
    final buffer = StringBuffer();
    for (final item in list) {
      buffer.write('$item,');
    }
    final file = File(path);
    file.writeAsString(buffer.toString());
  }

  static Future<List<int>> loadList(String path) async {
    final text = await rootBundle.loadString('packages/ringo/assets/$path');
    final data = text.split(',').map((e) => int.tryParse(e) ?? 0).toList();
    return data;
  }

  static Future<List<Word>> loadWords() async {
    final path = 'dic.csv';
    final text = await rootBundle.loadString('packages/ringo/assets/$path');
    final lines = text.split('\n');
    lines.remove('');
    final words = <Word>[];
    for (final line in lines) {
      final params = line.split(',');
      words.add(Word(
        word: params[0],
        leftContextId: int.tryParse(params[1]) ?? 0,
        rightContextId: int.tryParse(params[2]) ?? 0,
        occurrenceCost: int.tryParse(params[3]) ?? 0,
      ));
    }
    return words;
  }
}

import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';


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
    final text = await rootBundle.loadString('packages/ringo/assets/$path');//(await file.readAsLines()).first;
    final data = text.split(',').map((e) => int.tryParse(e) ?? 0).toList();
    return data;
  }


  static Future<List<String>> loadDic() async {
    final file = File(Directory.current.path + '/lib/src/dictionaly/dic.csv');
    final read = file.openRead();

    final lines =
      await read.transform(utf8.decoder).transform(LineSplitter()).toList();
    return lines;
  }
}